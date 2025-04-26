package backend;

class CoolInput
{
	// custom names for inputs (will be important later)
	public static function pressed(str:String):Bool
	{
		switch (str)
		{
			case "accept":
				return (FlxG.keys.justPressed.ENTER);
			case "noteLeft":
				return (FlxG.keys.justPressed.D);
			case "noteDown":
				return (FlxG.keys.justPressed.F);
			case "noteUp":
				return (FlxG.keys.justPressed.J);
			case "noteRight":
				return (FlxG.keys.justPressed.K);
			case "uiUp":
				return (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.W);
			case "uiDown":
				return (FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.S);
			case "uiLeft":
				return (FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.A);
			case "uiRight":
				return (FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.D);
			case "skipTime":
				return (FlxG.keys.justPressed.BACKSLASH);
			case "return":
				return (FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.BACKSPACE);
		}
		return false;
	}

	public static function held(str:String):Bool
	{
		switch (str)
		{
			case "noteLeft":
				return (FlxG.keys.pressed.D);
			case "noteDown":
				return (FlxG.keys.pressed.F);
			case "noteUp":
				return (FlxG.keys.pressed.J);
			case "noteRight":
				return (FlxG.keys.pressed.K);
			case "uiUp":
				return (FlxG.keys.pressed.UP || FlxG.keys.pressed.W);
			case "uiDown":
				return (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S);
			case "uiLeft":
				return (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A);
			case "uiRight":
				return (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D);
		}
		return false;
	}

	public static function released(str:String):Bool
	{
		switch (str)
		{
			case "noteLeft":
				return (FlxG.keys.justReleased.D);
			case "noteDown":
				return (FlxG.keys.justReleased.F);
			case "noteUp":
				return (FlxG.keys.justReleased.J);
			case "noteRight":
				return (FlxG.keys.justReleased.K);
			case "uiUp":
				return (FlxG.keys.justReleased.UP || FlxG.keys.justReleased.W);
			case "uiDown":
				return (FlxG.keys.justReleased.DOWN || FlxG.keys.justReleased.S);
			case "uiLeft":
				return (FlxG.keys.justReleased.LEFT || FlxG.keys.justReleased.A);
			case "uiRight":
				return (FlxG.keys.justReleased.RIGHT || FlxG.keys.justReleased.D);
		}
		return false;
	}
}
