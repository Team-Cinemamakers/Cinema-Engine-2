package backend;

class MathFunctions
{
	public static function isInRange(val1:Float, val2:Float, range:Float):Bool
	{
		return (val1 >= val2 - range && val1 <= val2 + range);
	}

	//I had to custom make this because Math.abs outputs incorrect cuz of fucking course it does
	public static function notShittyAbsolute(val:Float){
		if(val >= 0){
			return val;
		} else{
			return val * -1;
		}
	}
}
