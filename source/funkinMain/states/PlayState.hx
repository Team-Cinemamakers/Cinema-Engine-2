package funkinMain.states;

import backend.events.BeatEvent;
import flixel.system.debug.stats.Stats;
import funkinMain.data.Song;
import funkinMain.data.SongEvent;
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

	public var song:SongData;

	var loadAhead:Int = 50;
	var totalNotes:Float = 0;

	var amntLoaded:Array<Int> = [];

	override public function create()
	{
		super.create();
		ZOrder.flushSprites();
		ZOrder.addScreenSpace(this);

		Conductor.evDisp.addEventListener(Conductor.beatEvent.type, beatHit);

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		strumlines = new FlxTypedGroup<Strumline>();

		notes = new FlxTypedGroup<Note>();

		debTimer = new FlxTimer();

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
		song.metadata.scrollSpeed *= 0.25;
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
		moveNotes(elapsed);
		renderNotes();
	}

	function beatHit(e:BeatEvent)
	{
		if (Conductor.curBeat % 2 == 0 && !bopDeb)
			bf.animation.play("Idle", true);
	}

	function activateNote(note:Int, animation:String)
	{
		for (i in 0...notes.length)
		{
			if (notes.members[i] != null && notes.members[i].strumline.playable && notes.members[i].moving && notes.members[i].noteData.value == note)
			{
				var currentNote:Note = notes.members[i];
				var hitPoint:Float = currentNote.strumline.members[currentNote.noteData.value].y;
				if (currentNote != null && isInRange(currentNote.y, hitPoint, 100))
				{
					noteHit(currentNote, animation);
				}
			}
		}
	}

	function playAnimation(char:Character, anim:String)
	{
		// letting you know for some reason bfs animations are all only his misses
		bopDeb = true;
		char.animation.play(anim, true);
		debTimer.start(1, function(tmr:FlxTimer)
		{
			bopDeb = false;
		});
	}
	// calls note graphics and adds them
	function loadNote(lowest:StrumlineData, i:Int, note:NoteData)
	{
		var note:Note = new Note(strumlines.members[i].strumNotes[note.value].angle, strumlines.members[i], note, 0, 0,
			strumlines.members[i].members[note.value].scale.x, strumlines.members[i].members[note.value].scale.y);

		notes.add(note.loadNoteGraphic());
	}

	// function to check for soonest non-rendered note across all strums if there is space for a new note to load, and then renders it
	function renderNotes()
	{
		if (notes.length >= loadAhead || notes == null || song == null || strumlines == null || song.strumlines.length == 0)
			return;
			// set to shut up syntax
		if (song.strumlines[0] == null)
			return;
			var lowest:StrumlineData = song.strumlines[0];
			var int:Int = 0;
			var timeToCheck:Float = -1;
			for (i in 0...song.strumlines.length)
			{
				if (song.strumlines[i].notes[amntLoaded[i]] == null)
					return;
				
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
		loadNote(lowest, int, lowest.notes[amntLoaded[int]]);
		amntLoaded[int]++;
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
						// for some reason this doesnt remove the notes from memory, i have no idea why
					noteMiss(curNote, "");
					}
			}
		}		
	}
	function noteHit(note:Note, animation:String)
	{
		playAnimation(bf, animation);

		notes.remove(note, true);
		note.destroy();
	}

	function noteMiss(note:Note, animation:String)
	{
		notes.remove(note, true);
		note.destroy();
	}
	function isInRange(val1:Float, val2:Float, range:Float):Bool
	{
		return (val1 >= val2 - range && val1 <= val2 + range);
	}
}
