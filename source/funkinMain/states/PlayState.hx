package funkinMain.states;

import backend.events.BeatEvent;
import cpp.vm.Gc;
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
	var notes:FlxTypedGroup<Note>;
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

	override public function create()
	{
		super.create();
		Gc.run(true);

		camUI = new FlxCamera(0, 0, 1280, 720, 1);
		camUI.bgColor = FlxColor.TRANSPARENT;

		camGame = FlxG.camera;
		FlxG.cameras.add(camUI, false);

		camGame.zoom = 0.7;

		ZOrder.flushSprites();
		ZOrder.addScreenSpace(this);

		Conductor.evDisp.addEventListener(Conductor.beatEvent.type, beatHit);

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		strumlines = new FlxTypedGroup<Strumline>();

		notes = new FlxTypedGroup<Note>();

		debTimer = new FlxTimer();

		song = Song.fromFile('dad-battle');
		
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
		}

		ZOrder.addToBackground(mainStage, 0);

		mainStage.build();
		ZOrder.addToBackground(mainStage);

		MusicHandler.loadInstAndVoices('dad-battle', song.metadata.songFiles.inst, song.metadata.songFiles.vocals);

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

		var stageScript:HScript = new HScript("stageScript");
        stageScript.load("test");
        stageScript.run("main");
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		Conductor.addConductorTime(elapsed, this);

		if (CoolInput.pressed("noteLeft"))
		{
			activateNote(0, 'singLEFT');
		}
		if (CoolInput.pressed("noteDown"))
		{
			activateNote(1, 'singDOWN');
		}
		if (CoolInput.pressed("noteUp"))
		{
			activateNote(2, 'singUP');
		}
		if (CoolInput.pressed("noteRight"))
		{
			activateNote(3, 'singRIGHT');
		}
		// calls function to move the loaded notes (putting this in strumlines actually might be less optimized)
		// why the FUCK did move notes in the playstate and not the fuckin note itself
	}

	function beatHit(e:BeatEvent)
	{
		if (Conductor.curBeat % 2 == 0 && !bopDeb)
			bf.animation.play("Idle", true);
	}

	// someone fix input system pls
	function activateNote(note:Int, animation:String)
	{
		for (i in 0...notes.length)
		{
			if (notes.members[i] != null && notes.members[i].strumline.playable != false && notes.members[i].noteData.value == note){
				if (notes.members[i].clickedOnRow())
					{
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
			strumlines.members[i].members[note.value].scale.x, strumlines.members[i].members[note.value].scale.y);

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

	// checks for notes that are rendered and if it is time to move them, if so, moves them up based on funky shit
	function moveNotes(elapsed:Float)
	{
		if (notes.length == 0 || notes == null)
			return;

		var scrollAmount:Float = (song.metadata.scrollSpeed * elapsed) * 1000;
		for (i in 0...notes.length)
		{
			if (notes.members[i] == null)
				return;
			var curNote:Note = notes.members[i];
			if (curNote.noteData.time
				- (((FlxG.height +
					curNote.height / 2) - curNote.strumline.members[curNote.noteData.value].y) / ((song.metadata.scrollSpeed) * 1000) * 1000) <= Conductor.TIME)
				{
					if (!curNote.moving)
						curNote.moving = true;
					curNote.y -= scrollAmount;
					if (curNote.y <= -1 * curNote.height)
				{
					noteMiss(curNote, "");
					}
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
}
