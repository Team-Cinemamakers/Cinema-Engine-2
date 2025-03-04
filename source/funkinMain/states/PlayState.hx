package funkinMain.states;

import backend.events.BeatEvent;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();
		Conductor.evDisp.addEventListener(Conductor.beatEvent.type, beatHit);

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		MusicHandler.loadInstAndVoices('dad-battle');

		// resets conductor and also plays loaded inst and voices on music handler
		Conductor.reset(180, true);
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