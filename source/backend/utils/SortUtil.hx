package backend.utils;

import flixel.group.FlxGroup;
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

    /**
        Reorders the group/state. Lower Z objects go in the back, while higher Z objects go in the front.
    **/
    public static function reorder(?group:FlxGroup) {
        group ??= FlxG.state;
        group.sort(SortUtil.sortByZOrder, FlxSort.ASCENDING);
    }
}

/**
    Pre-defined layers for easier ordering
**/
class ZLayers {
    // Game layers
    public static inline var BACKGROUND:Int = 0;
    public static inline var CHARACTER:Int = 10;
    public static inline var FOREGROUND:Int = 15;

    // UI layers
    public static inline var UI_BACKGROUND:Int = 0;
    public static inline var UI:Int = 10;
    public static inline var UI_FOREGROUND:Int = 25;
}