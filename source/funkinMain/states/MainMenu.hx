package funkinMain.states;

import backend.events.*;
import cpp.vm.Gc;
import funkinMain.objects.Alphabet;
import funkinMain.objects.Transition;
import funkinMain.states.FreeplayState;
import openfl.events.Event;
import openfl.events.EventType;

class MainMenu extends FlxState
{
	var bg:FlxSprite;
	var mainMenu:ScrollableMenu;
	var menuOptions:FlxTypedGroup<Alphabet>;
	var curItem:Int = 0;
	var transition:Transition;
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

		menuOptions = new FlxTypedGroup<Alphabet>();
		add(menuOptions);

		for (i in 0...mainMenuOptions.length)
		{
			var yIterator:Float = (i * (100 + 75)) + 62.5;
			var newAlphabet = new Alphabet(mainMenuOptions[i], i, 50, 0, yIterator, true, true);
			menuOptions.add(newAlphabet);
			add(newAlphabet);
		}
		menuOptions.members[0].setScale(true);

		Conductor.evDisp.addEventListener(Conductor.beatEvent.type, beatHit);
		transition = new Transition();
		add(transition);
		transition.play(1);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// gets input from custom input callouts (CoolInput) and checks if it is just pressed
		if (CoolInput.pressed("accept"))
		{
			switch (curItem)
			{
				case 0:
					FlxG.switchState(() -> new PlayState());
				case 1:
					transition.play(-1);
					new FlxTimer().start(1.5, function(tmr:FlxTimer){
						FlxG.switchState(() -> new FreeplayState());
					});
			}
		}
		if (CoolInput.pressed("uiDown"))
		{
			scroll(-1);
		}
		else if (CoolInput.pressed("uiUp"))
		{
			scroll(1);
		}
		if(FlxG.sound.music != null){
			Conductor.setConductorTime(FlxG.sound.music.time, this);
		}
	}

	override function destroy()
	{
		Conductor.evDisp.removeEventListener(Conductor.beatEvent.type, beatHit);
		Gc.run(true);
		menuOptions = null;

		super.destroy();
	}

	public function scroll(value:Int)
	{
		menuOptions.members[curItem].setScale(false);
		value *= -1;
		if (curItem + value >= menuOptions.length)
		{
			curItem = 0;
		}
		else if (curItem + value < 0)
		{
			curItem = menuOptions.length - 1;
		}
		else
		{
			curItem += value;
		}
		FlxG.sound.play(Paths.audio('audio/sounds/scrollMenu'));

		menuOptions.members[curItem].setScale(true);
	}

	function beatHit(e:Event) {
		
	}
}
