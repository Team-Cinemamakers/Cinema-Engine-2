package backend.utils;

/**
	Collection of math-related functions
**/
class MathUtil
{
	/**
		Checks whether 2 values are in range of each other
		@param val1 First value to check
		@param val2 Second value to check
		@param range Maximum range for success

		@return Result of the operation
	**/
	public static function isInRange(val1:Float, val2:Float, range:Float):Bool
	{
		return (val1 >= val2 - range && val1 <= val2 + range);
	}

	
	public static function absolute(val:Float):Float {
		if(val >= 0){
			return val;
		} else{
			return val * -1;
		}
	}

	public static function hexToRGB(hex:String):Array<Float> {
		var ri:Int = Std.parseInt("0x" + hex.substr(2, 2));
		var gi:Int = Std.parseInt("0x" + hex.substr(4, 2));
		var bi:Int = Std.parseInt("0x" + hex.substr(6, 2));

		trace(ri);
		trace(gi);
		trace(bi);

		var r:Float = ri/255;
		var g:Float = gi/255;
		var b:Float = bi/255;

		return [r, g, b];
	}
}
