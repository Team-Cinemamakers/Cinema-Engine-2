package backend;

class CoolInput
{
	/**
		Whether a specified input was pressed last frame
		@param input Input to check
	**/
	public static function pressed(input:String):Bool
	{
		switch (input)
		{
			case "accept":
				return (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE);
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
			case "plus":
				return (FlxG.keys.justPressed.RBRACKET);
			case "minus":
				return (FlxG.keys.justPressed.LBRACKET);
		}
		return false;
	}

	/**
		Whether a specified input is being held
		@param input Input to check
	**/
	public static function held(input:String):Bool
	{
		switch (input)
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

	/**
		Whether a specified input was released last frame
		@param input Input to check
	**/
	public static function released(input:String):Bool
	{
		switch (input)
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
