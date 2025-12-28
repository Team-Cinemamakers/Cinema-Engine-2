package;

import backend.scripting.Scripts;
import flixel.FlxGame;
import flixel.addons.display.FlxZoomCamera;
import flixel.system.debug.console.ConsoleHistory;
import funkin.states.TitleState;
import openfl.display.Sprite;
import openfl.utils.Assets;
import source.backend.CinemaGame;

class Main extends Sprite
{
	public static var conductor:Conductor;
	public static var performanceDisplay:backend.PerformanceDisplay;
	public function new()
	{
		super();

		Assets.cache.enabled = false;

		FlxSprite.defaultAntialiasing = true;

		conductor = new Conductor();

		FlxG.autoPause = false;

		var game = new CinemaGame(0, 0, TitleState, 180, 180, true);
		addChild(game);
		performanceDisplay = new PerformanceDisplay();
		addChild(performanceDisplay);
	}
}
