package;

import flixel.FlxGame;
import flixel.addons.display.FlxZoomCamera;
import flixel.system.debug.console.ConsoleHistory;
import funkin.states.TitleState;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var conductor:Conductor;
	public static var performanceDisplay:backend.PerformanceDisplay;
	public static var zOrder:ZOrder;
	public function new()
	{
		super();

		zOrder = new ZOrder(5);

		FlxSprite.defaultAntialiasing = true;

		// create that conductor!
		conductor = new Conductor();

		FlxG.autoPause = false;

		addChild(new FlxGame(0, 0, TitleState, 180, 180, true));
		performanceDisplay = new PerformanceDisplay();
		addChild(performanceDisplay);
	}
}
