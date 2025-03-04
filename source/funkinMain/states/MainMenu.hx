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

		FlxG.autoPause = false;

		// plays conductor with bpm 102 according to the music bpm (102)
		Conductor.play(102);

		if(FlxG.sound.music == null){
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		bg = new FlxSprite().loadGraphic(Paths.stateAssets("mainMenu/menuBG"));
		bg.screenCenter();
		add(bg);
		Conductor.evDisp.addEventListener(Conductor.mainBeatEvent.type, beatHit);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// gets input from custom input callouts (CoolInput) and checks if it is just pressed
		if (CoolInput.pressed("accept"))
		{
			FlxG.switchState(new PlayState());
		}
		Conductor.addConductorTime(elapsed, this);
	}

	function beatHit(e:Event)
	{
		if (FlxG.state == this)
		{
			trace("I DID IT");
		}
	}
}
