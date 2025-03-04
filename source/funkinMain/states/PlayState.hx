package funkinMain.states;

import openfl.events.Event;
import openfl.events.EventDispatcher;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();
		Conductor.evDisp.addEventListener(Conductor.mainBeatEvent.type, beatHit);

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		MusicHandler.loadInstAndVoices('dad-battle');

		Conductor.reset(180, true);
	}
    
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		Conductor.addConductorTime(elapsed, this);
	}

	function beatHit(e:Event)
	{
		trace("I DID IT");
	}
}