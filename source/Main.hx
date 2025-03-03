package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		FlxG.autoPause = false;
		addChild(new FlxGame(0, 0, MainMenu, 60, 60, true));
	}
}
