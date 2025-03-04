package funkinMain.states;

import backend.data.Song;
import backend.events.BeatEvent;

class PlayState extends FlxState
{
	public static var song:SongChart;
	override public function create()
	{
		super.create();
		Conductor.evDisp.addEventListener(Conductor.beatEvent.type, beatHit);

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		song = Song.fromFile('dad-battle');

		MusicHandler.loadInstAndVoices('dad-battle', song.metadata.songFiles.inst, song.metadata.songFiles.vocals);

		// resets conductor and also plays loaded inst and voices on music handler
		Conductor.reset(song.metadata.bpm, true);
	}
    
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		Conductor.addConductorTime(elapsed, this);
		// trace(MusicHandler.inst.time);
		// trace(MusicHandler.voices.time);
	}

	function beatHit(e:BeatEvent)
	{
	}
}