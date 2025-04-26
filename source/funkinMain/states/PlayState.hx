package funkinMain.states;

import backend.events.BeatEvent;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.debug.stats.Stats;
import funkinMain.data.Song;
import funkinMain.data.SongEvent;
import funkinMain.data.Stage;
import funkinMain.objects.Character;
import funkinMain.objects.Note;
import funkinMain.objects.Strumline;

class PlayState extends FlxState
{
	var bf:Character;
	var strumlines:FlxTypedGroup<Strumline>;
	static var notes:FlxTypedGroup<Note>;
	public static var loadedSong:String;
	// chart note array of array to allow support for more than 2 characters

	var debTimer:FlxTimer;

	var bopDeb:Bool = false;

	var notesLoaded:Bool = false;

	public static var song:SongData;
	public var stage:StageFile;

	var loadAhead:Int = 50;
	var totalNotes:Float = 0;

	var camGame:FlxCamera;
	var camUI:FlxCamera;

	var amntLoaded:Array<Int> = [];

	var mainStage:Stage = new Stage("stage");

	var baseZoom:Float = 0.85;
	var cameraTween:FlxTween;
	var lastCameraTween:Float = 0;
	var paused:Bool = false;
	var noteSparrow:FlxAtlasFrames;

	var camCenterX:Float = -170;
	var camCenterY:Float = -150;
	
	var hitNoteDebounce:Array<Bool> = [];

	override public function create()
	{
		super.create();

		AssetTracking.destroyUnusedAssets(true);

		noteSparrow = Paths.sparrow('images/shared/notes');

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

		notes = new FlxTypedGroup<Note>();

		debTimer = new FlxTimer();

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
			trace('Could not find song Defaulting to Dad Battle');
			MusicHandler.loadInstAndVoices('dad-battle', 'Inst', 'Vocals');
		}

		// resets conductor and also plays loaded inst and voices on music handler
		Conductor.reset(song.metadata.bpm, true);

		bf = new Character('bf');
		bf.animation.play("Idle", true);
		bf.x = mainStage.data.characters[0].position[0];
		bf.y = mainStage.data.characters[0].position[1];
		
		ZOrder.addToCharacters(bf);
		// Load in strums

		ZOrder.addToUIBackground(strumlines, 1);
		ZOrder.addToUIBackground(notes, 2);

		song.metadata.scrollSpeed *= 0.25;
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
			resyncNotes();
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
		if (Conductor.curBeat % 2 == 0){
			if(!bopDeb){
				bf.animation.play("Idle", true);
				FlxTween.tween(camGame, {x: camCenterX + bf.animCamOffsets["Idle"].x, y: camCenterY + bf.animCamOffsets["Idle"].y}, 0.25, {
					ease: FlxEase.quadInOut
				});
			}
			lastCameraTween = camGame.zoom * 1.03;
			camGame.zoom = lastCameraTween;
		}
	}

	// someone fix input system pls
	function activateNote(note:Int, animation:String)
	{
		for (i in 0...notes.length)
		{
			if (notes.members[i] != null && notes.members[i].strumline.playable != false && notes.members[i].noteData.value == note){
				if (notes.members[i].clickedOnRow() && !hitNoteDebounce[notes.members[i].noteData.value])
					{
						hitNoteDebounce[notes.members[i].noteData.value] = true;

						notes.members[i].strumline.members[notes.members[i].noteData.value].pressedOnNote = true;
						var ah:Note = notes.members[i];
						notes.remove(ah);
						ah.destroy();

						playAnimation(bf, animation, true);
					}
			}
		}
	}

	function playAnimation(char:Character, anim:String, force:Bool = false)
	{
		// letting you know for some reason bfs animations are all only his misses
		bopDeb = true;
		char.playAnimation(anim, force);
		FlxTween.tween(camGame, {x: camCenterX + char.animCamOffsets[anim].x, y: camCenterY + char.animCamOffsets[anim].y}, 0.25, {
			ease: FlxEase.quadInOut
		});
		debTimer.start(1, function(tmr:FlxTimer)
		{
			bopDeb = false;
		});
	}
	// calls note graphics and adds them
	function loadNote(i:Int, note:NoteData)
	{
		// optimized this by removing the need for stupid ass functions n shit
		var noteNew:Note = new Note(strumlines.members[i].strumNotes[note.value].angle, strumlines.members[i], note, 0, 0,
			strumlines.members[i].members[note.value].scale.x, strumlines.members[i].members[note.value].scale.y, noteSparrow);

		noteNew.cameras = [camUI];
		notes.add(noteNew);
	}

	// just pre-renders all notes cuz FUCK whatever I had before
	function renderNotes()
	{
		for (i in 0...song.strumlines.length)
		{
			for (j in 0...song.strumlines[i].notes.length)
			{
				loadNote(i, song.strumlines[i].notes[j]);
			}
		}
	}

	function noteHit(note:Note, animation:String)
	{
		playAnimation(bf, animation, true);

		notes.remove(note, true);
		note.destroy();
	}

	function noteMiss(note:Note, animation:String)
	{
		notes.remove(note, true);
		note.destroy();
	}

	public static function resyncNotes(){
		for(i in 0...notes.length){
			if(notes.members[i] != null){
				notes.members[i].recalculateNoteScreenPosition();
			}
		}
	}
}
