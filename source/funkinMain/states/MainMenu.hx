package funkinMain.states;

import backend.events.*;
import cpp.vm.Gc;
import openfl.events.Event;
import openfl.events.EventType;

class MainMenu extends FlxState
{
	var bg:FlxSprite;
	var mainMenu:ScrollableMenu;
	// DONT ADD SPACES IT WILL FUCKING NOT ADD THEM (I gotta make that work but later cuz im lazy)
	static var mainMenuOptions:Array<String> = ['StoryMode', 'Freeplay', 'Options', 'Credits'];

	override public function create()
	{
		super.create();

		if (!FlxG.sound.music.playing || FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(Paths.audio('audio/music/freakyMenu'));
		}

		bg = new FlxSprite().loadGraphic(Paths.stateImage("mainMenu/menuBG"));
		bg.screenCenter();
		add(bg);

		mainMenu = new ScrollableMenu(mainMenuOptions, 50, 20, 100);

		Conductor.evDisp.addEventListener(Conductor.beatEvent.type, beatHit);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// gets input from custom input callouts (CoolInput) and checks if it is just pressed
		if (CoolInput.pressed("accept"))
		{
			switch (mainMenu.curItem)
			{
				case 0:
					FlxG.switchState(() -> new PlayState());
			}
		}
		if (CoolInput.pressed("uiDown"))
		{
			mainMenu.scroll(-1);
		}
		else if (CoolInput.pressed("uiUp"))
		{
			mainMenu.scroll(1);
		}
		Conductor.addConductorTime(elapsed, this);
	}

	override function destroy()
	{
		mainMenu.selectDestroy();
		super.destroy();

		Gc.run(true);

		Conductor.evDisp.removeEventListener(Conductor.beatEvent.type, beatHit);
	}

	function beatHit(e:BeatEvent)
	{
		trace("I DID IT");
	}
}
