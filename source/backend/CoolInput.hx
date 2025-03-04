package backend;

class CoolInput
{
	// custom names for inputs (will be important later)
    public static function pressed(str:String):Bool{
        switch (str) {
			case "accept":
                return(FlxG.keys.justPressed.ENTER);
        }
		return false;
    }
}