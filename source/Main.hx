package;

import flixel.FlxGame;
import flixel.system.debug.console.ConsoleHistory;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var conductor:Conductor;
	public function new()
	{
		super();

		conductor = new Conductor();

		FlxG.autoPause = false;

		addChild(new FlxGame(0, 0, MainMenu, 60, 60, true));
	}
}
