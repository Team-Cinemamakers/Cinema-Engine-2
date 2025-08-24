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

class PlayState extends FlxState
{
	var bf:Character;
	var strumlines:FlxTypedGroup<Strumline>;

	public static var notes:Map<Int, Note> = [];

	public static var notesTypedGroup:FlxTypedGroup<Note>;

	public static var loadedSong:String;
	// chart note array of array to allow support for more than 2 characters

	var notesLoaded:Bool = false;

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
	var noteSparrow:FlxAtlasFrames;

	var camCenterX:Float = -170;
	var camCenterY:Float = -150;

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

		noteSparrow = Paths.sparrow('notes', 'images/shared', ENGINE);

		camUI = new FlxCamera(0, 0, 1280, 720, 1);
		camUI.bgColor = FlxColor.TRANSPARENT;

		camGame = FlxG.camera;
		FlxG.cameras.add(camUI, false);

		camGame.zoom = baseZoom;

		camGame.width = 4500;
		camGame.height = 3500;

		camGame.x = camCenterX;
		camGame.y = camCenterY;

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
			song = Song.fromFile('dad-battle');
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
			MusicHandler.loadInstAndVoices('dad-battle', 'Inst', 'Vocals');
		}

		// resets conductor and also plays loaded inst and voices on music handler
		Conductor.reset(song.metadata.bpm, true);

		bf = new Character('bf');
		bf.animation.play("Idle", true);
		bf.x = mainStage.data.characters[0].position[0];
		bf.y = mainStage.data.characters[0].position[1];
		characters.push(bf);
		
		ZOrder.addToCharacters(bf);
		// Load in strums

		ZOrder.addToUIBackground(strumlines, 1);
		ZOrder.addToUIBackground(notesTypedGroup, 2);

		scrollSpeed = song.metadata.scrollSpeed * 7;
		renderNotes();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

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
				playAnimation(characters[i], 'Idle', true);
			}
		}
	}

	// i fixed ts
	function activateNote(noteVal:Int, animation:String)
	{
		if(notes != null) return;

		for (note in notes)
		{
			if (note != null && note.strumline.playable != false && note.noteData.value == noteVal){
				if (note.clickedOnRow() && !hitNoteDebounce[note.noteData.value])
					{
						hitNoteDebounce[note.noteData.value] = true;

						note.strumline.members[note.noteData.value].pressedOnNote = true;
						var ah:Note = note;
						notes.remove(note.iterator);
						ah.destroy();

						playAnimation(bf, animation, true);
					}
			}
		}
	}

	function playAnimation(char:Character, anim:String, force:Bool = false)
	{
		// letting you know for some reason bfs animations are all only his misses
		char.playAnimation(anim, force);
		FlxTween.tween(camGame, {x: camCenterX + char.animCamOffsets[anim].x, y: camCenterY + char.animCamOffsets[anim].y}, 0.25, {
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
		notes.set(j, noteNew);
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

	function noteHit(note:Note, animation:String)
	{
		playAnimation(bf, animation, true);

		notes.remove(note.iterator);
		note.destroy();
	}

	function noteMiss(note:Note, animation:String)
	{
		notes.remove(note.iterator);
		note.destroy();
	}
}
