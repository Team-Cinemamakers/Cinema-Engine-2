package backend;

import flixel.util.FlxSort;

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

/**
Z-Ordering class

Compared to V-Slice it removes boilerplate code from states
**/
class ZOrder extends FlxTypedGroup<FlxBasic>{

    /**
        Reorders the group/state. Lower Z objects go in the back, while higher Z objects go in the front.
    **/
    public static function reorder(state:FlxTypedGroup<FlxBasic>) {
        state.sort(SortUtil.sortByZOrder, FlxSort.ASCENDING);
    }

}