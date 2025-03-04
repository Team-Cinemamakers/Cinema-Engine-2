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

		if (CoolInput.pressed("enter"))
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
