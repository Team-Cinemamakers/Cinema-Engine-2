package funkinMain.states;

import backend.events.*;
import cpp.vm.Gc;
import funkinMain.objects.Transition;
import funkinMain.states.*;
import funkinMain.states.TitleState;
import openfl.events.Event;
import openfl.events.EventType;

class MainMenu extends FlxState
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

		AssetTracking.destroyUnusedAssets(true);

		if (!FlxG.sound.music.playing || FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(Paths.audio('audio/music/freakyMenu'));
		}

		bg = new FlxSprite().loadGraphic(Paths.stateImage("mainMenu/menuBG"));
		bg.screenCenter();
		add(bg);

		menuOptions = new FlxTypedGroup<FlxSprite>();
		add(menuOptions);

		for (i in 0...mainMenuOptions.length)
		{
			var yIterator:Float = (i * (100 + 75)) + 62.5;
			var item:FlxSprite = new FlxSprite();
			item.frames = Paths.sparrow("images/stateAssets/mainMenu/menu_" + mainMenuSparrow[i]);
			item.animation.addByPrefix('white', mainMenuSparrow[i] + ' basic', 8, true);
			item.animation.addByPrefix('basic', mainMenuSparrow[i] + ' white', 8, true);
			item.animation.play('basic', true);
			item.scale.set(0.6, 0.6);
			item.updateHitbox();
			item.screenCenter(X);
			item.y = yIterator;
			menuOptions.add(item);
			add(item);
		}

		menuOptions.members[0].animation.play('white', true);
		menuOptions.members[0].scale.set(1.1, 1.1);
		menuOptions.members[0].updateHitbox();

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
		} else if (CoolInput.pressed("return")){
			transition.play(-1);
			new FlxTimer().start(1.5, function(tmr:FlxTimer){
				FlxG.switchState(() -> new TitleState());
			});
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
		menuOptions.members[curItem].animation.play('basic', true);
		menuOptions.members[curItem].scale.set(0.6, 0.6);
		menuOptions.members[curItem].updateHitbox();
		menuOptions.members[curItem].screenCenter(X);
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

		menuOptions.members[curItem].animation.play('white', true);
		menuOptions.members[curItem].scale.set(1.1, 1.1);
		menuOptions.members[curItem].updateHitbox();
		menuOptions.members[curItem].screenCenter(X);
	}

	function beatHit(e:Event) {
		
	}
}
