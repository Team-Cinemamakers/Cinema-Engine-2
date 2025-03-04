package funkinMain.states;

import backend.events.BeatEvent;
import backend.events.StepEvent;
// import backend.events.StepEvent;
import openfl.events.Event;
import openfl.events.EventDispatcher;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();
		Conductor.evDisp.addEventListener(Conductor.beatEvent.type, beatHit);
		Conductor.evDisp.addEventListener(Conductor.stepEvent.type, stepHit);

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
		trace("I DID IT");
	}
	function stepHit(e:StepEvent)
	{
		trace("STEP");
	}
}