package backend;

class CoolInput
{
	// custom names for inputs (will be important later)
    public static function pressed(str:String):Bool{
        switch (str) {
			case "accept":
                return(FlxG.keys.justPressed.ENTER);
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
        }
		return false;
    }
}