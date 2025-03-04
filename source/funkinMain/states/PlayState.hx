package funkinMain.states;

import backend.events.BeatEvent;
import funkinMain.data.Song;
import funkinMain.objects.Character;
import funkinMain.objects.StrumNote;

class PlayState extends FlxState
{
	var bf:Character;
	var testStrum:StrumNote;

	public static var song:SongChart;

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
		// testing testing
		testStrum = new StrumNote("noteUp");
		ZOrder.addToUIForeground(testStrum, 1);
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