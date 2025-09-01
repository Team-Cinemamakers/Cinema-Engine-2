package backend.utils;

import flixel.util.FlxSort;

/**
    Collection of sorting-related functions
**/
class SortUtil {
    /**
        Sorts by the FlxBasic's Z-Index value
    **/
    inline public static function sortByZOrder(ZOrder:Int, a:flixel.FlxBasic, b:flixel.FlxBasic):Int
	{
		if (a == null || b == null) return 0;
		return FlxSort.byValues(ZOrder, a.zIndex, b.zIndex);
	}
}