package funkinMain.states;

import backend.events.BeatEvent;
import funkinMain.data.Song;
import funkinMain.objects.Character;
import funkinMain.objects.Note;
import funkinMain.objects.Strumline;

class PlayState extends FlxState
{
	var bf:Character;
	var strumlines:FlxTypedGroup<Strumline>;

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
		// Create notes
		for (i in 0...song.strumlines.length) // TODO: MAKE THIS MORE OPTIMIZED
		{
			for (j in 0...song.strumlines[i].notes.length)
			{
				var note:Note = new Note(strumlines.members[i].members[j].angle, strumlines.members[i], song.strumlines[i].notes[j].value,
					song.strumlines[i].notes[j].type, 0, 1300);

				note.scale.set(strumlines.members[i].members[j].scale.x, strumlines.members[i].members[j].scale.y);
				ZOrder.addToUIBackground(note, 2);
				FlxTween.tween(note, {y: strumlines.members[i].members[j].y}, song.strumlines[i].notes[j].time);
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
}
