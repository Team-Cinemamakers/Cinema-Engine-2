package funkinMain.states;

import backend.events.BeatEvent;
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
	var chartNotes:Array<Note> = [];

	public static var song:SongData;

	override public function create()
	{
		super.create();
		ZOrder.flushSprites();
		ZOrder.addScreenSpace(this);

		Conductor.evDisp.addEventListener(Conductor.beatEvent.type, beatHit);

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		song = Song.fromFile('dad-battle');

		MusicHandler.loadInstAndVoices('dad-battle', song.metadata.songFiles.inst, song.metadata.songFiles.vocals);

		// resets conductor and also plays loaded inst and voices on music handler
		Conductor.reset(song.metadata.bpm, true);
		bf = new Character('bf');
		bf.animation.play("Idle", true);
		ZOrder.addToCharacters(bf);
		// Load in strums

		strumlines = new FlxTypedGroup<Strumline>();

		notes = new FlxTypedGroup<Note>();

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
		}

		ZOrder.addToUIBackground(strumlines, 1);
		ZOrder.addToUIBackground(notes, 2);
		// Create notes
		for (i in 0...song.strumlines.length) // preloads all note info but not graphics
		{
			for (j in 0...song.strumlines[i].notes.length)
			{
				var note:Note = new Note(strumlines.members[i].members[j].angle, strumlines.members[i], song.strumlines[i].notes[j].value,
					song.strumlines[i].notes[j].type, 0, 1300, strumlines.members[i].members[j].scale.x, strumlines.members[i].members[j].scale.y,
					song.strumlines[i].notes[j].time);

				chartNotes.push(note);

				// loading all the graphics immedietally anyway for testing purposes before adding the calculated load
				// loadNote(note);
			}
		}
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
		if (notes.length != 0 && notes != null)
		{
			for (i in 0...notes.length)
			{
				if (notes.members[i].time <= Conductor.TIME && !notes.members[i].moving)
				{
					notes.members[i].moving = true;
					FlxTween.tween(notes.members[i], {y: -100}, 3 * 1 / song.metadata.scrollSpeed, {
						onComplete: function(twn:FlxTween)
						{
							var noteToRemove:Note = notes.members[i];
							notes.members.remove(noteToRemove);
							chartNotes.remove(noteToRemove);
							noteToRemove.destroy();
							// clears note from memory
						}
					});
				}
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
	function loadNote(note:Note)
	{
		note.loadNoteGraphic(notes);
	}
}
