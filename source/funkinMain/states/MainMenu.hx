package funkinMain.states;

import flixel.FlxState;

class MainMenu extends FlxState
{
	var bg:FlxSprite;

	override public function create()
	{
		super.create();

		FlxG.autoPause = false;

		if(FlxG.sound.music == null){
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		bg = new FlxSprite().loadGraphic(Paths.stateAssets("mainMenu/menuBG"));
		bg.screenCenter();
		add(bg);
		trace(Input.mainInputJson);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
