package;

import flixel.FlxGame;
import flixel.system.debug.console.ConsoleHistory;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var conductor:Conductor;
	public static var performanceDisplay:backend.PerformanceDisplay;
	public function new()
	{
		super();

		// create that conductor!
		conductor = new Conductor();

		FlxG.autoPause = false;

		addChild(new FlxGame(0, 0, MainMenu, 60, 60, true));
		performanceDisplay = new PerformanceDisplay();
		addChild(performanceDisplay);
	}
}
