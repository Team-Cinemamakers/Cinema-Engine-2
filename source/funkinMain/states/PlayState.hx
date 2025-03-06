package funkinMain.states;

import backend.events.BeatEvent;
import funkinMain.data.Song;
import funkinMain.data.SongEvent;
import funkinMain.objects.Character;
import funkinMain.objects.Note;
import funkinMain.objects.Strumline;

typedef FailedNoteData =
{
	var time:Float; // time at which the note is supposed to be pressed
	var type:Int; // note type (0 for normal)
	var value:Int; // value (corresponds to the place in the strumline, so on 4k its from 0-3 and on 7k its from 0-6 and so on)
}
class PlayState extends FlxState
{
	var bf:Character;
	var strumlines:FlxTypedGroup<Strumline>;
	var notes:FlxTypedGroup<Note>;
	// chart note array of array to allow support for more than 2 characters
	var chartNotesArray:Array<Array<Note>> = [];

	var fnd:FailedNoteData;

	var notesLoaded:Bool = false;

	public var song:SongData;

	var loadAhead:Int = 50;
	var totalNotes:Float = 0;

	var amntLoaded:Array<Int> = [];

	override public function create()
	{
		super.create();
		ZOrder.flushSprites();
		ZOrder.addScreenSpace(this);

		fnd = {time: 10000, type: 0, value: 1};

		Conductor.evDisp.addEventListener(Conductor.beatEvent.type, beatHit);

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		strumlines = new FlxTypedGroup<Strumline>();

		notes = new FlxTypedGroup<Note>();

		song = Song.fromFile('dad-battle');
		for (i in 0...song.strumlines.length)
		{
			totalNotes += song.strumlines[i].notes.length;
		}
		loadAhead = Std.int(totalNotes / 5);
		
		// Create strumlines
		for (i in 0...song.metadata.strumlines.length)
		{
			trace(song.metadata.strumlines[i]);
			var strumLine:Strumline = new Strumline(song.metadata.strumlines[i].strumNotes, song.metadata.strumlines[i].character,
				song.metadata.strumlines[i].playable, song.metadata.strumlines[i].kerning, song.metadata.strumlines[i].position[0],
				song.metadata.strumlines[i].position[1]);

			strumLine.scale = song.metadata.strumlines[i].scale;
			strumLine.updateStrums();

			strumlines.add(strumLine);
			var na:Array<Note> = [];
			chartNotesArray.push(na);
			amntLoaded.push(0);
		}

		MusicHandler.loadInstAndVoices('dad-battle', song.metadata.songFiles.inst, song.metadata.songFiles.vocals);

		// resets conductor and also plays loaded inst and voices on music handler
		Conductor.reset(song.metadata.bpm, true);
		bf = new Character('bf');
		bf.animation.play("Idle", true);
		ZOrder.addToCharacters(bf);
		// Load in strums

		ZOrder.addToUIBackground(strumlines, 1);
		ZOrder.addToUIBackground(notes, 2);
		// Create notes
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		Conductor.addConductorTime(elapsed, this);
		// trace(MusicHandler.inst.time);
		// trace(MusicHandler.voices.time);
		if (CoolInput.pressed("noteLeft"))
		{
			activateNote(0, 'singLEFT');
		}
		if (CoolInput.pressed("noteDown"))
		{
			activateNote(1, 'signDOWN');
		}
		if (CoolInput.pressed("noteUp"))
		{
			activateNote(2, 'singUP');
		}
		if (CoolInput.pressed("noteRight"))
		{
			activateNote(3, 'singRIGHT');
		}
		// checks for notes that are rendered and if it is time to move them, if so, moves them up based on funky shit
		if (notes.length != 0 && notes != null)
		{
			var scrollAmount:Float = 3 * song.metadata.scrollSpeed * (elapsed * 100);
			for (i in 0...notes.length)
			{
				var curNote:Note = notes.members[i];
				if (curNote != null
					&& curNote.noteData.time - ((FlxG.height + curNote.height)
						- (curNote.strumline.members[curNote.noteData.value].y) / scrollAmount) <= Conductor.TIME)
				{
					curNote.y -= scrollAmount;
					if (curNote.y <= -1 * curNote.height)
					{
						// for some reason this doesnt remove the notes from memory, i have no idea why
						notes.remove(curNote, true);
						curNote.destroy();
					}
				}
			}
		}
		// function to check for soonest non-rendered note across all strums if there is space for a new note to load, and then renders it
		if (!notesLoaded && song != null && strumlines != null && song.strumlines.length != 0)
		{
			// set to shut up syntax
			var lowest:StrumlineData = song.strumlines[0];
			var int:Int = 0;
			var timeToCheck:Float = -1;
			for (i in 0...song.strumlines.length)
			{
				if (timeToCheck == -1)
				{
					timeToCheck = song.strumlines[i].notes[amntLoaded[i]].time;
					lowest = song.strumlines[i];
					int = i;
				}
				else if (timeToCheck > song.strumlines[i].notes[amntLoaded[i]].time)
				{
					timeToCheck = song.strumlines[i].notes[amntLoaded[i]].time;
					lowest = song.strumlines[i];
					int = i;
				}
			}
			if (notes != null && notes.length < 50 && song.strumlines[0] != null)
			{
				loadNote(lowest, int, lowest.notes[amntLoaded[int]]);
				amntLoaded[int]++;
			}
		}
	}

	function beatHit(e:BeatEvent)
	{
		if (Conductor.curBeat % 2 == 0)
			bf.animation.play("Idle", true);
	}

	function activateNote(note:Int, animation:String)
	{
		playAnimation(bf, animation);
	}

	function playAnimation(char:Character, anim:String)
	{
		// letting you know for some reason bfs animations are all only his misses
		// char.animation.play(anim, true);
	}
	// calls note graphics and adds them
	function loadNote(lowest:StrumlineData, i:Int, note:NoteData)
	{
		var note:Note = new Note(strumlines.members[i].strumNotes[note.value].angle, strumlines.members[i], note, 0, 0,
			strumlines.members[i].members[note.value].scale.x, strumlines.members[i].members[note.value].scale.y);

		notes.add(note.loadNoteGraphic());
	}
}
