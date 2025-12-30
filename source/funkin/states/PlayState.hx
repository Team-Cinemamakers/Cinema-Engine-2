package funkin.states;

import backend.Globals.NoteRating;
import backend.events.BeatEvent;
import backend.scripting.Scripts.EventProcess;
import flixel.FlxObject;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.debug.stats.Stats;
import funkin.data.Song;
import funkin.data.SongEvent;
import funkin.data.Stage;
import funkin.objects.Bar;
import funkin.objects.Character;
import funkin.objects.LongNote;
import funkin.objects.Note;
import funkin.objects.StrumNote;
import funkin.objects.Strumline;
import funkin.objects.Transition;
#if !html5
import cpp.vm.ExecutionTrace;
#end

class PlayState extends FlxState
{
	var bf:Character;
	var strumlines:FlxTypedGroup<Strumline>;

	public var notesTypedGroup:FlxTypedGroup<Note>;

	public static var loadedSong:String;

	// chart note array of array to allow support for more than 2 characters
	var notesLoaded:Bool = false;

	public var noteInts:Array<Int> = [];

	public static var song:Song;

	public var stage:StageFile;

	var loadAhead:Int = 50;
	var totalNotes:Float = 0;

	var camGame:FlxCamera;
	var camUI:FlxCamera;

	public var hud:HScript = null;

	public var characters:Map<String, Character> = [];

	// public var mainStage:Stage = new Stage("stage");
	public var stages:Map<String, Stage> = [];
	public var currentStage:Stage;

	var baseZoom:Float = 0.85;
	var cameraTween:FlxTween;
	var lastCameraTween:Float = 0;

	public var paused:Bool = false;
	public var songEnded:Bool = false;

	public var noteSparrow:FlxAtlasFrames;

	var camCenterX:Float = -350;
	var camCenterY:Float = -350;

	var animDeb:Array<Float> = [];

	public static var scrollSpeed:Float = 0;

	public static var instance:PlayState;

	var hitNoteDebounce:Array<Bool> = [];

	public static var hitsound:FlxSound;

	var desiredCamPos:FlxPoint;

	public static var health:Float = 1.0; // im health
	public static var misses:Int = 0; // im misses
	public static var score:Int = 0; // im score
	// we're the song stat brothers

	var camFollow:FlxObject; // I like this system ngl.

	var timeSinceLastNote:Float = 0;

	var initialized:Bool = false;

	override public function create()
	{
		super.create();
		instance = this;

		Scripts.callOnScripts("onPlaystatePreInit", []);

		initialized = false;

		health = 1.0;

		misses = 0;
		score = 0;

		desiredCamPos = FlxPoint.get(0, 0);
		// #if desktop
		// Gc.run(true);
		// #end

		hitsound = FlxG.sound.load(Paths.audio("scrollMenu", "audio/sounds", ENGINE));

		Conductor.evDisp.addEventListener(Conductor.beatEvent.type, beatHit);

		noteSparrow = Paths.sparrow('notes', 'images/shared', ENGINE);

		camUI = new FlxCamera(0, 0, 1280, 720, 1);
		camUI.bgColor = FlxColor.TRANSPARENT;

		camGame = FlxG.camera;
		FlxG.cameras.add(camUI, false);

		//camGame.width = 12;
		//camGame.height = 3500;

		if (loadedSong == null)
		{
			loadedSong = 'beat-the-meat';
			trace("Could not find song, defaulting to " + MiscUtil.capitalize(loadedSong.replace("-", " ")));
		}

		song = new Song(loadedSong);

		for (stageDef in song.info.stages)
		{
			var stage:Stage = new Stage(stageDef);

			stage.build();
			stage.setVisibility(false);

			stages.set(stageDef, stage);
			stage = null;
		}
		currentStage = stages[song.info.stages[0]];
		currentStage.setVisibility(true);

		baseZoom = currentStage.data.baseZoom;

		camGame.zoom = baseZoom;

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		strumlines = new FlxTypedGroup<Strumline>();
		strumlines.zIndex = ZLayers.UI;

		notesTypedGroup = new FlxTypedGroup<Note>();
		notesTypedGroup.zIndex = ZLayers.UI;

		// Create character declarations
		for (charData in song.info.characters)
		{
			var charPos = currentStage.getPositionFromMarker(charData.positionMarker);
			var char:Character = new Character(charData.character, charPos.x, charPos.y);

			characters.set(charData.name, char);
		}

		// Create strumlines
		for (i in 0...song.info.strumlines.length)
		{
			var strumLine:Strumline = new Strumline(song.info.strumlines[i].strumNotes, song.info.strumlines[i].characters, song.info.strumlines[i].playable,
				song.info.strumlines[i].kerning, song.info.strumlines[i].position[0], song.info.strumlines[i].position[1], i);

			strumLine.scale = song.info.strumlines[i].scale;
			strumLine.updateStrums();

			strumLine.cameras = [camUI];

			strumlines.add(strumLine);
			trace('added strumline ' + i);

			for (k in 0...strumLine.strumNotes.length)
			{
				if (strumLine.playable)
				{
					hitNoteDebounce.push(false);
				}
			}
		}

		add(strumlines);
		add(notesTypedGroup);

		SongHandler.load(loadedSong, song.info.songFiles.inst, song.info.songFiles.vocals, song.tempDir);
		SongHandler.inst.onComplete = endSong;

		// resets conductor and also plays loaded inst and voices on music handler
		Conductor.reset(song.info.bpm, true);

		if (characters.get(strumlines.members[0].characterNames[0]).cameraOffset != null)
		{
			camCenterX = characters.get(strumlines.members[0].characterNames[0]).getCameraPos(strumlines.members[0].playable).x;
			camCenterY = characters.get(strumlines.members[0].characterNames[0]).getCameraPos(strumlines.members[0].playable).y;
		}

		/*camFollow = new FlxObject(0, 0, 1, 1);
		camFollow.setPosition(camCenterX, camCenterY);

		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0);
		FlxG.camera.snapToTarget();

		trace(camFollow.getPosition());
		trace(FlxG.camera.x + " " + FlxG.camera.y);*/

		FlxG.camera.scroll.x = camCenterX;
		FlxG.camera.scroll.y = camCenterY;

		for (i in 0...strumlines.length)
			animDeb[i] = 0;

		// Load in strums

		for (char in characters)
		{
			char.zIndex = ZLayers.CHARACTER;
			add(char);
		}

		scrollSpeed = song.info.scrollSpeed * 7;
		renderNotes();

		

		// #if desktop
		// Gc.run(true);
		// #end

		for(char in characters){
			desiredCamPos = FlxPoint.get(char.x + char.animCamOffsets.get('Idle').x + char.cameraOffset.x, char.y + char.animCamOffsets.get('Idle').y + char.cameraOffset.y);
			break; // just get first character
		}

		if (song.info.hud == null) {
			trace("Hud script not specified, returning to default");
			initHUD('BaseHUD');
		} else initHUD(song.info.hud);

		Scripts.callOnScripts("onPlaystatePostInit", []);

		SortUtil.reorder();

		song.strumlines = null;

		if(!initialized){
			initialized = true;
		}
	}

	override function destroy() {
		super.destroy();

		instance = null;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		Scripts.callOnScripts("preUpdate", [elapsed]);

		processInputs();

		for (i in 0...animDeb.length)
		{
			animDeb[i] += elapsed;
		}

		if (SongHandler.inst != null && SongHandler.voices != null)
		{
			if (SongHandler.inst.length >= SongHandler.voices.length)
			{
				Conductor.setConductorTime(SongHandler.inst.time);
			}
			else
			{
				Conductor.setConductorTime(SongHandler.voices.time);
			}
		}
		else if (SongHandler.inst != null)
		{
			Conductor.setConductorTime(SongHandler.inst.time);
		}

		processEvents();

		if (camGame.zoom != baseZoom && !MathUtil.isInRange(camGame.zoom, baseZoom, 0.01))
		{
			if (camGame.zoom > baseZoom)
			{
				camGame.zoom -= 0.2 * elapsed;
			}
			else
			{
				camGame.zoom += 0.2 * elapsed;
			}
		}
		else if (MathUtil.isInRange(camGame.zoom, baseZoom, 0.005))
		{
			camGame.zoom = baseZoom;
		}

		if (health > 2) health = 2;
		if (health < 0) health = 0;

		if(FlxPoint.get(camGame.scroll.x, camGame.scroll.y) != desiredCamPos){
			FlxG.camera.scroll.x += (((desiredCamPos.x - (FlxG.camera.width/2))- FlxG.camera.scroll.x) * (5 * elapsed));
			FlxG.camera.scroll.y += ((desiredCamPos.y - (FlxG.camera.height/2) - FlxG.camera.scroll.y) * (5 * elapsed));
		}

		timeSinceLastNote += elapsed;

		Scripts.callOnScripts("update", [elapsed]);
	}

	function beatHit(e:BeatEvent)
	{
		Scripts.callOnScripts("preBeatHit", []);

		if(!initialized || strumlines == null || strumlines.length <= 0)return;
		if (Conductor.curBeat % 2 == 0)
		{
			for (i in 0...strumlines.length)
			{
				if (animDeb[i] >= 0.2)
				{
					animDeb[i] = 0;
					for (v in 0...strumlines.members[i].characters.length)
					{
						playAnimation(strumlines.members[i].characters[v], 'Idle', true, strumlines.members[i].playable);
					}
				}
			}
		}

		Scripts.callOnScripts("beatHit", []);
	}

	public function endSong() {
		if (songEnded) return;
		var eventReturn = Scripts.callOnScripts("songEnd", []);
		if (Scripts.getCallEventResult(eventReturn) == EventProcess.CANCEL)
			return;

		songEnded = true;

		song = null;
		strumlines = null;

		var transition:Transition = new Transition();
		transition.cameras = [camUI];
		transition.play(Transition.DOWN, 0.5, () -> FlxG.switchState(() -> new MainMenuState()));
		add(transition);
		
	}

	// i fixed ts
	function activateNote(noteVal:Int, animation:String, input:String)
	{
		if (notesTypedGroup.length <= 0)
			return;

		for (i in 0...notesTypedGroup.length)
		{
			if (notesTypedGroup.members[i] != null)
			{
				var thisNote:Note = notesTypedGroup.members[i];
				if (thisNote.noteData.value == noteVal
					&& thisNote.strumnote.playable
					&& MathUtil.isInRange(thisNote.y, thisNote.strumnote.y, 140))
				{
					var hitType:NoteRating = NoteRating.BAD;
					if (MathUtil.isInRange(thisNote.y, thisNote.strumnote.y, 30))
					{
						hitType = NoteRating.PERFECT;
						score += 100;
					}
					else if (MathUtil.isInRange(thisNote.y, thisNote.strumnote.y, 60))
					{
						hitType = NoteRating.GREAT;
						score += 75;
					}
					else if (MathUtil.isInRange(thisNote.y, thisNote.strumnote.y, 90))
					{
						hitType = NoteRating.GOOD;
						score += 50;
					}
					thisNote.strumnote.pressedOnNote = true;
					for (v in 0...thisNote.strumnote.characters.length)
					{
						noteHit(thisNote, thisNote.strumnote.input, thisNote.strumnote.characters[v], thisNote.strumnote.playable);
					}
					SongHandler.voices.volume = 1;
					if(thisNote.longNote != null){
						thisNote.alpha = 0;
						thisNote.held = true;
						trace('clicked long note');
						thisNote.input = input;
					} else {
						thisNote.destroy();
						notesTypedGroup.remove(thisNote, true);
					}
					
				}
			}
		}
	}

	function deactivateNote(noteVal:Int)
	{
		for (i in 0...strumlines.length)
		{
			if (strumlines.members[i].members[noteVal].playable && strumlines.members[i].members[noteVal].pressedOnNote)
				strumlines.members[i].members[noteVal].pressedOnNote = false;
		}
	}

	var newTmr:Array<FlxTimer> = [];

	public function activateEnemyNote(strumnote:StrumNote, value:Int)
	{
		if(timeSinceLastNote >= (60/Conductor.BPM) * 2) desiredCamPos = FlxPoint.get(strumnote.characters[0].x + strumnote.characters[0].animCamOffsets.get(strumnote.input).x + strumnote.characters[0].cameraOffset.x, strumnote.characters[0].y + strumnote.characters[0].animCamOffsets.get(strumnote.input).y + strumnote.characters[0].cameraOffset.y);
		for (i in 0...strumnote.characters.length)
		{
			SongHandler.voices.volume = 1;
			playAnimation(strumnote.characters[i], strumnote.input, true);
			if (newTmr[value] != null)
			{
				newTmr[value].cancel();
			}
			newTmr[value] = new FlxTimer().start(0.05, function(tmr:FlxTimer)
			{
				strumnote.pressedOnNote = false;
			});
		}
	}

	var camTween:FlxTween;

	function playAnimation(char:Character, anim:String, force:Bool = false, playable:Bool = false)
	{
		char.playAnimation(anim, force);
		if (!playable)
			return;

		// if(camTween != null){
		// 	camTween.cancel();
		// }
		// camTween = FlxTween.tween(camGame, {x: camCenterX - char.animCamOffsets[anim].x, y: camCenterY - char.animCamOffsets[anim].y}, 0.1, {
		// 	ease: FlxEase.quadInOut
		// });
	}



	// calls note graphics and adds them
	function loadNote(i:Int, note:NoteData, j:Int)
	{
		// trace('starting loading note' + j);
		// optimized this by removing the need for stupid ass functions n shit
		var noteNew:Note = new Note(strumlines.members[i].strumNotes[note.value].angle, strumlines.members[i], note, 0, 0,
			strumlines.members[i].members[note.value].scale.x, strumlines.members[i].members[note.value].scale.y, noteSparrow, j);

		noteNew.cameras = [camUI];
		// trace('loaded note' + j);
	}

	// just pre-renders all notes cuz FUCK whatever I had before
	function renderNotes()
	{
		var total:Int = 0;
		for (i in 0...song.strumlines.length)
		{
			for (j in 0...song.strumlines[i].notes.length)
			{
				// trace('renderingNotes');
				loadNote(i, song.strumlines[i].notes[j], total);
				total++;
			}
		}
	}

	public function noteHit(note:Note, animation:String, char:Character, playable:Bool)
	{
		var eventReturn = Scripts.callOnScripts("noteHit", [note, char, playable]);
		if (Scripts.getCallEventResult(eventReturn) == EventProcess.CANCEL)
			return;

		var eventData = {
			health: 0.023,
			doAnimation: true
		};
		eventData = Scripts.getCombinedCallResult(eventReturn, eventData);

		health += eventData.health;

		if (eventData.doAnimation) {
			animDeb[0] = 0;
			playAnimation(char, animation, true, playable);
		}	
		desiredCamPos = FlxPoint.get(char.x + char.animCamOffsets.get(animation).x + char.cameraOffset.x, char.y + char.animCamOffsets.get(animation).y + char.cameraOffset.y);
		timeSinceLastNote = 0;
	}

	public function noteMiss(note:Note, animation:String)
	{
		var eventReturn = Scripts.callOnScripts("noteMiss", [note]);
		if (Scripts.getCallEventResult(eventReturn) == EventProcess.CANCEL) {
			note.destroy();
			return;
		}

		var eventData = {
			health: 0.0475,
			misses: 1,
			muteVoices: true,
			doAnimation: true
		};
		eventData = Scripts.getCombinedCallResult(eventReturn, eventData);

		if(note.longNote != null) trace('long note missed');
		health -= eventData.health;
		misses += eventData.misses;

		if (eventData.muteVoices)
			SongHandler.voices.volume = 0;

		if (eventData.doAnimation) {
			for (v in 0...note.strumnote.characters.length)
			{
				playAnimation(note.strumnote.characters[v], animation+"Miss", true, note.strumnote.playable);
			}
		}

		note.destroy();
	}

	function processEvents()
	{
		if(song == null)return;
		for (event in song.events)
		{
			if (Conductor.TIME >= event.time && !event.triggered)
			{
				event.trigger();
			}
		}
	}

	function processInputs()
	{
		if (CoolInput.pressed("noteLeft"))
		{
			hitNoteDebounce[0] = false;
			activateNote(0, 'singLEFT', "noteLeft");
		}
		if (CoolInput.pressed("noteDown"))
		{
			hitNoteDebounce[1] = false;
			activateNote(1, 'singDOWN', "noteDown");
		}
		if (CoolInput.pressed("noteUp"))
		{
			hitNoteDebounce[2] = false;
			activateNote(2, 'singUP', "noteUp");
		}
		if (CoolInput.pressed("noteRight"))
		{
			hitNoteDebounce[3] = false;
			activateNote(3, 'singRIGHT', "noteRight");
		}
		
		if (CoolInput.pressed("skipTime"))
		{
			SongHandler.skipTime(5000);
		}
		if (CoolInput.pressed("plus"))
		{
			scrollSpeed *= 1.1;
		}
		if (CoolInput.pressed("minus"))
		{
			scrollSpeed *= 0.9;
		}
		if (CoolInput.pressed("accept"))
		{
			if (!paused)
			{

				// // will pause
				// song = null;
				// FlxG.switchState(() -> new MainMenuState());// For convenience or something
				// strumlines = null; 
			}
		}
	}

	function initHUD(name:String) {
		if (Paths.exists(Paths.hscript(name, "hud"))) {
			hud = Scripts.create(name + "-hud", Paths.hscript(name, "hud"), ScriptContext.HUD);
		} else {
			hud = Scripts.create(name + "-hud", Paths.hscript("BaseHUD", "hud"), ScriptContext.HUD); 
		}

		hud.set("add", add);
		hud.set("remove", remove);
		hud.set("this", this);
	} 
}
