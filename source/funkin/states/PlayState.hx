package funkin.states;

import backend.Globals.NoteRating;
import backend.events.BeatEvent;
import backend.scripting.Scripts.EventProcess;
import cpp.vm.ExecutionTrace;
import flixel.FlxObject;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.debug.stats.Stats;
import funkin.data.Song;
import funkin.data.SongEvent;
import funkin.data.Stage;
import funkin.objects.Character;
import funkin.objects.LongNote;
import funkin.objects.Note;
import funkin.objects.StrumNote;
import funkin.objects.Strumline;

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

	public var characters:Map<String, Character> = [];

	// public var mainStage:Stage = new Stage("stage");
	public var stages:Map<String, Stage> = [];
	public var currentStage:Stage;

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

	public static var health:Float = 1.0;

	var camFollow:FlxObject; // I like this system ngl.

	override public function create()
	{
		super.create();

		AssetTracking.destroyUnusedAssets(true);
		// #if desktop
		// Gc.run(true);
		// #end

		hitsound = FlxG.sound.load(Paths.audio("scrollMenu", "audio/sounds", ENGINE));

		instance = this;

		Conductor.evDisp.addEventListener(Conductor.beatEvent.type, beatHit);

		noteSparrow = Paths.sparrow('notes', 'images/shared', ENGINE);

		camUI = new FlxCamera(0, 0, 1280, 720, 1);
		camUI.bgColor = FlxColor.TRANSPARENT;

		camGame = FlxG.camera;
		FlxG.cameras.add(camUI, false);

		camGame.width = 4500;
		camGame.height = 3500;

		if (loadedSong == null)
		{
			trace("Could not find song, defaulting to Dad Battle");
			loadedSong = 'beat-the-meat';
		}

		song = new Song(loadedSong);

		for (stageDef in song.info.stages)
		{
			var stage:Stage = new Stage(stageDef);

			stage.build();
			stage.setVisibility(false);

			stages.set(stageDef, stage);
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

		SongHandler.load(loadedSong, song.info.songFiles.inst, song.info.songFiles.vocals);

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

		SortUtil.reorder();

		// #if desktop
		// Gc.run(true);
		// #end
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

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
	}

	function beatHit(e:BeatEvent)
	{
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
	}

	// i fixed ts
	function activateNote(noteVal:Int, animation:String)
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
					}
					else if (MathUtil.isInRange(thisNote.y, thisNote.strumnote.y, 60))
					{
						hitType = NoteRating.GREAT;
					}
					else if (MathUtil.isInRange(thisNote.y, thisNote.strumnote.y, 90))
					{
						hitType = NoteRating.GOOD;
					}
					thisNote.strumnote.pressedOnNote = true;
					notesTypedGroup.remove(thisNote, true);
					for (v in 0...thisNote.strumnote.characters.length)
					{
						noteHit(thisNote, thisNote.strumnote.input, thisNote.strumnote.characters[v], thisNote.strumnote.playable);
					}
					if(thisNote.longNote != null) thisNote.longNote.destroy();
					thisNote.destroy();
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
		for (i in 0...strumnote.characters.length)
		{
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
		health += 0.023;
		var ret = Scripts.callOnScripts("noteHit", [note, char, playable]);
		if (Scripts.getCallEventResult(ret) == EventProcess.CANCEL)
			return;

		animDeb[0] = 0;
		playAnimation(char, animation, true, playable);
	}

	public function noteMiss(note:Note, animation:String)
	{
		health -= 0.0475;
		var ret = Scripts.callOnScripts("noteMiss", [note]);
		if (Scripts.getCallEventResult(ret) == EventProcess.CANCEL)
			return;

		for (v in 0...note.strumnote.characters.length)
		{
			playAnimation(note.strumnote.characters[v], animation+"Miss", true, note.strumnote.playable);
		}

		note.destroy();
	}

	function processEvents()
	{
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
			activateNote(0, 'singLEFT');
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
				// will pause
				FlxG.switchState(() -> new MainMenuState()); // For convenience or something
			}
		}
	}

	function onSongComplete()
	{
		FlxG.switchState(() -> new MainMenuState());
	}
}
