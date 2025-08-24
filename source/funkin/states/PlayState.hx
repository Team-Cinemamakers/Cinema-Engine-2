package funkin.states;

import backend.events.BeatEvent;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.debug.stats.Stats;
import funkin.data.Song;
import funkin.data.SongEvent;
import funkin.data.Stage;
import funkin.objects.Character;
import funkin.objects.Note;
import funkin.objects.Strumline;
import funkin.objects.StrumNote;

class PlayState extends FlxState
{
	var bf:Character;
	var strumlines:FlxTypedGroup<Strumline>;

	public var notesTypedGroup:FlxTypedGroup<Note>;

	public static var loadedSong:String;
	// chart note array of array to allow support for more than 2 characters

	var notesLoaded:Bool = false;
	public var noteInts:Array<Int> = [];

	public static var song:SongData;
	public var stage:StageFile;

	var loadAhead:Int = 50;
	var totalNotes:Float = 0;

	var camGame:FlxCamera;
	var camUI:FlxCamera;

	var characters:Array<Character> = [];

	var amntLoaded:Array<Int> = [];

	var mainStage:Stage = new Stage("stage");

	var baseZoom:Float = 0.85;
	var cameraTween:FlxTween;
	var lastCameraTween:Float = 0;
	var paused:Bool = false;
	public var noteSparrow:FlxAtlasFrames;

	var camCenterX:Float = -350;
	var camCenterY:Float = -350;

	var animDeb:Array<Float> = [];

	public static var scrollSpeed:Float = 0;
	

	public static var instance:PlayState;

	var hitNoteDebounce:Array<Bool> = [];

	public static var hitsound:FlxSound;

	override public function create()
	{
		super.create();

		hitsound = FlxG.sound.load(Paths.audio("audio/sounds/scrollMenu", "", ENGINE));

		instance = this;

		AssetTracking.destroyUnusedAssets(true);
		Gc.run(true);

		noteSparrow = Paths.sparrow('notes', 'images/shared', ENGINE);

		camUI = new FlxCamera(0, 0, 1280, 720, 1);
		camUI.bgColor = FlxColor.TRANSPARENT;

		camGame = FlxG.camera;
		FlxG.cameras.add(camUI, false);

		camGame.zoom = baseZoom;

		camGame.width = 4500;
		camGame.height = 3500;

		ZOrder.flushSprites();
		ZOrder.addScreenSpace(this);

		Conductor.evDisp.addEventListener(Conductor.beatEvent.type, beatHit);

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		strumlines = new FlxTypedGroup<Strumline>();

		notesTypedGroup = new FlxTypedGroup<Note>();

		if(loadedSong != null){
			song = Song.fromFile(loadedSong);
		} else {
			trace('Could not find song Defaulting to Dad Battle');
			song = Song.fromFile('feddy-whop');
		}
		
		// Create strumlines
		for (i in 0...song.metadata.strumlines.length)
		{
			var strumLine:Strumline = new Strumline(song.metadata.strumlines[i].strumNotes, song.metadata.strumlines[i].character,
				song.metadata.strumlines[i].playable, song.metadata.strumlines[i].kerning, song.metadata.strumlines[i].position[0],
				song.metadata.strumlines[i].position[1]);

			strumLine.scale = song.metadata.strumlines[i].scale;
			strumLine.updateStrums();

			strumLine.cameras = [camUI];

			strumlines.add(strumLine);
			amntLoaded.push(0);

			for(k in 0...strumLine.strumNotes.length){
				if(strumLine.playable){
					hitNoteDebounce.push(false);
				}
			}
		}

		ZOrder.addToBackground(mainStage, 0);

		mainStage.build();
		ZOrder.addToBackground(mainStage);

		if(loadedSong != null){
			MusicHandler.loadInstAndVoices(loadedSong, song.metadata.songFiles.inst, song.metadata.songFiles.vocals);
		} else {
			trace('Could not find song. Defaulting to Dad Battle');
			MusicHandler.loadInstAndVoices('feddy-whop', 'Inst', 'Vocals');
		}

		// resets conductor and also plays loaded inst and voices on music handler
		Conductor.reset(song.metadata.bpm, true);

		bf = new Character('bf');
		bf.animation.play("Idle", true);
		bf.x = mainStage.data.characters[0].position[0];
		bf.y = mainStage.data.characters[0].position[1];
		characters.push(bf);

		camGame.x = camCenterX;
		camGame.y = camCenterY;

		animDeb[0] = 0;
		
		ZOrder.addToCharacters(bf);
		// Load in strums

		ZOrder.addToUIBackground(strumlines, 1);
		ZOrder.addToUIBackground(notesTypedGroup, 2);

		scrollSpeed = song.metadata.scrollSpeed * 7;
		renderNotes();

		Gc.run(true);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		for(i in 0...animDeb.length){
			animDeb[i] += elapsed;
		}

		if(MusicHandler.inst != null && MusicHandler.voices != null){
			if(MusicHandler.inst.length >= MusicHandler.voices.length){
				Conductor.setConductorTime(MusicHandler.inst.time, this);
			} else {
				Conductor.setConductorTime(MusicHandler.voices.time, this);
			}
		} else if (MusicHandler.inst != null){
			Conductor.setConductorTime(MusicHandler.inst.time, this);
		}
		
		if(camGame.zoom != baseZoom && !MathFunctions.isInRange(camGame.zoom, baseZoom, 0.01)){
			if(camGame.zoom > baseZoom){
				camGame.zoom -= 0.2 * elapsed;
			} else {
				camGame.zoom += 0.2 * elapsed;
			} 
		} else if(MathFunctions.isInRange(camGame.zoom, baseZoom, 0.005)){
			camGame.zoom = baseZoom;
		}

		if (CoolInput.pressed("noteLeft"))
		{
			hitNoteDebounce[0] = false;
			activateNote(0, 'singLEFT');
		} else {
			deactivateNote(0);
		}
		if (CoolInput.pressed("noteDown"))
		{
			hitNoteDebounce[1] = false;
			activateNote(1, 'singDOWN');
		}
		if (CoolInput.pressed("noteUp"))
		{
			hitNoteDebounce[2] = false;
			activateNote(2, 'singUP');
		}
		if (CoolInput.pressed("noteRight"))
		{
			hitNoteDebounce[3] = false;
			activateNote(3, 'singRIGHT');
		}
		if (CoolInput.pressed("skipTime"))
		{
			MusicHandler.skipTime(5000);
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
				if(!paused){
					//will pause
				}
			}
		// calls function to move the loaded notes (putting this in strumlines actually might be less optimized)
		// why the FUCK did move notes in the playstate and not the fuckin note itself
	}

	function beatHit(e:BeatEvent)
	{
		if(Conductor.curBeat % 4 == 0){
			for(i in 0...characters.length){
				if(animDeb[i] >= 0.15){
					animDeb[i] = 0;
					playAnimation(characters[i], 'Idle', true);
				}
			}
		}
	}

	// i fixed ts
	function activateNote(noteVal:Int, animation:String)
	{
		if(notesTypedGroup.length <= 0) return;

		for (i in 0...notesTypedGroup.length)
		{
			if(notesTypedGroup.members[i] != null){
				var thisNote:Note = notesTypedGroup.members[i];
				if(thisNote.noteData.value == noteVal && thisNote.strumnote.playable && MathFunctions.isInRange(thisNote.y, thisNote.strumnote.y, 140)){
					var hitType:String = 'Meh';
					if(MathFunctions.isInRange(thisNote.y, thisNote.strumnote.y, 30)){
						hitType = 'Perfect';
					} else if(MathFunctions.isInRange(thisNote.y, thisNote.strumnote.y, 60)){
						hitType = 'Great';
					} else if(MathFunctions.isInRange(thisNote.y, thisNote.strumnote.y, 90)){
						hitType = 'Good';
					}
					thisNote.strumnote.pressedOnNote = true;
					notesTypedGroup.remove(thisNote, true);
					noteHit(thisNote.strumnote.input);
					thisNote.destroy();
					trace('Hit note rating: ' + hitType);
				}
			}
		}
	}

	function deactivateNote(noteVal:Int){
		for(i in 0...strumlines.length){
			if(strumlines.members[i].members[noteVal].playable && strumlines.members[i].members[noteVal].pressedOnNote) strumlines.members[i].members[noteVal].pressedOnNote = false;
		}
	}

	var newTmr:Array<FlxTimer> = [];
	public function activateEnemyNote(strumnote:StrumNote, value:Int){
		if(newTmr[value] != null){
			newTmr[value].cancel();
		}
		newTmr[value] = new FlxTimer().start(0.05, function(tmr:FlxTimer){
			strumnote.pressedOnNote = false;
		});
	}

	var camTween:FlxTween;
	function playAnimation(char:Character, anim:String, force:Bool = false)
	{
		char.playAnimation(anim, force);
			if(camTween != null){
				camTween.cancel();
			}
			camTween = FlxTween.tween(camGame, {x: camCenterX - char.animCamOffsets[anim].x, y: camCenterY - char.animCamOffsets[anim].y}, 0.25, {
				ease: FlxEase.quadInOut
			});
	}
	// calls note graphics and adds them
	function loadNote(i:Int, note:NoteData, j:Int)
	{
		// trace('starting loading note' + j);
		// optimized this by removing the need for stupid ass functions n shit
		var noteNew:Note = new Note(strumlines.members[i].strumNotes[note.value].angle, strumlines.members[i], note, 0, 0,
			strumlines.members[i].members[note.value].scale.x, strumlines.members[i].members[note.value].scale.y, noteSparrow, j);

		noteNew.cameras = [camUI];
		//trace('loaded note' + j);
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

	function noteHit(animation:String)
	{
		animDeb[0] = 0;
		playAnimation(bf, animation, true);
	}

	function noteMiss(note:Note, animation:String)
	{
		note.destroy();
	}

	function onSongComplete(){
		FlxG.switchState(() -> new MainMenuState());
	}
}
