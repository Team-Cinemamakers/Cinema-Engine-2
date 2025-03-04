package backend;

class CoolInput
{
    public static function pressed(str:String):Bool{
        switch (str) {
            case "enter":
                return(FlxG.keys.justPressed.ENTER);
        }
		return false;
    }
}