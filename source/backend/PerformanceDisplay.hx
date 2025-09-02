package backend;

import openfl.text.TextField;
import openfl.text.TextFormat;

class PerformanceDisplay extends TextField
{
	public var times:Array<Float> = [];
	public var currentFPS:Int = 0;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0xFFFFFF)
	{
		super();

		this.x = x;
		this.y = y;

		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("_sans", 14, color);
		background = true;
		backgroundColor = 0x80000000;
		alpha = 0.5;
		autoSize = LEFT;
		multiline = false;

		updateText();
	}

	// Stolen from nightmarevision :^
	var deltaTimeout:Float = 0.0;

	private override function __enterFrame(deltaTime:Float):Void
	{
		final now:Float = haxe.Timer.stamp() * 1000;
		times.push(now);
		while (times[0] < now - 1000)
			times.shift();

		// Prevents the overlay from updating every frame, why would you need to anyways @crowplexus
		if (deltaTimeout < 1000)
		{
			deltaTimeout += deltaTime;
			return;
		}
		currentFPS = times.length < FlxG.updateFramerate ? times.length : FlxG.updateFramerate;
		updateText();
		deltaTimeout = 0.0;
	}

	private function updateText():Void
	{
		text = "FPS: " + currentFPS + "\nMemory: " + flixel.util.FlxStringUtil.formatBytes(openfl.system.System.totalMemoryNumber);
	}
}
