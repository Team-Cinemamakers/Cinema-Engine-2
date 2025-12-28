package funkin.states;

import backend.events.*;
import funkin.objects.Transition;
import funkin.states.*;
import funkin.states.TitleState;
import openfl.events.Event;
import openfl.events.EventType;
#if desktop
import cpp.vm.Gc;
#end

class MainMenuState extends FlxState
{
	var bg:FlxSprite;
	var mainMenu:ScrollableMenu;
	var menuOptions:FlxTypedGroup<FlxSprite>;
	var curItem:Int = 0;
	var transition:Transition;
	// DONT ADD SPACES IT WILL FUCKING NOT ADD THEM (I gotta make that work but later cuz im lazy)
	static var mainMenuOptions:Array<String> = ['StoryMode', 'Freeplay', 'Options', 'Credits'];
	static var mainMenuSparrow:Array<String> = ['story_mode', 'freeplay', 'options', 'credits'];

	override public function create()
	{
		super.create();

		if (FlxG.sound.music == null || !FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.audio('freakyMenu', 'audio/music', ENGINE));
		}

		bg = new FlxSprite().loadGraphic(Paths.image("menuBG", 'images/states/mainMenu', ENGINE));
		bg.screenCenter();
		add(bg);

		menuOptions = new FlxTypedGroup<FlxSprite>();
		add(menuOptions);

		for (i in 0...mainMenuOptions.length)
		{
			var yIterator:Float = (i * (100 + 75)) + 62.5;
			var item:FlxSprite = new FlxSprite();
			item.frames = Paths.sparrow("menu_" + mainMenuSparrow[i], 'images/states/mainMenu', ENGINE, item);
			item.animation.addByPrefix('idle', mainMenuSparrow[i] + ' idle', 24, true);
			item.animation.addByPrefix('selected', mainMenuSparrow[i] + ' selected', 24, true);
			item.animation.play('idle', true);
			// item.scale.set(0.6, 0.6);
			item.y = yIterator;
			item.screenCenter(X);
			item.updateHitbox();
			menuOptions.add(item);
		}

		scroll(0);

		transition = new Transition();
		add(transition);
		transition.play(1);

		SortUtil.reorder();
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
		} else if (CoolInput.pressed("return")){
			transition.play(-1);
			new FlxTimer().start(1.5, function(tmr:FlxTimer){
				FlxG.switchState(() -> new TitleState());
			});
		}
		if(FlxG.sound.music != null){
			Conductor.setConductorTime(FlxG.sound.music.time);
		}
	}

	override function destroy()
	{
		#if desktop
		Gc.run(true);
		#end
		menuOptions = null;

		super.destroy();
	}

	public function scroll(value:Int)
	{
		menuOptions.members[curItem].animation.play('idle');
		// menuOptions.members[curItem].scale.set(0.6, 0.6);
		menuOptions.members[curItem].updateHitbox();
		// menuOptions.members[curItem].screenCenter(X);
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
		FlxG.sound.play(Paths.audio('scrollMenu', 'audio/sounds', ENGINE));

		menuOptions.members[curItem].animation.play('selected');
		// menuOptions.members[curItem].scale.set(1.1, 1.1);
		menuOptions.members[curItem].centerOffsets();
		menuOptions.members[curItem].screenCenter(X);
	}
}
