package funkinMain.states;

import backend.events.*;
import openfl.events.Event;
import openfl.events.EventType;

class MainMenu extends FlxState
{
	var bg:FlxSprite;

	override public function create()
	{
		super.create();

		// starts conductor with bpm 102 according to the music bpm (102)
		Conductor.start(102);

		if(FlxG.sound.music == null){
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		trace(Paths.exists("assets/images/stateAssets/mainMenu/menuBG.png"));

		bg = new FlxSprite().loadGraphic(Paths.stateImage("mainMenu/menuBG"));
		bg.screenCenter();
		add(bg);
		Conductor.evDisp.addEventListener(Conductor.beatEvent.type, beatHit);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// gets input from custom input callouts (CoolInput) and checks if it is just pressed
		if (CoolInput.pressed("accept"))
		{
			FlxG.switchState(() -> new PlayState());
		}
		Conductor.addConductorTime(elapsed, this);
	}

	override function destroy()
	{
		super.destroy();

		Conductor.evDisp.removeEventListener(Conductor.beatEvent.type, beatHit);
	}

	function beatHit(e:BeatEvent)
	{
		trace("I DID IT");
	}
}
