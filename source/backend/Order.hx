package backend;

import flixel.util.FlxSort;

class Layers {
    // Game layers
    public static inline var BACKGROUND:Int = 10;
    public static inline var CHARACTER:Int = 100;
    public static inline var FOREGROUND:Int = 125;

    // UI layers
    public static inline var UI:Int = 1000;
    public static inline var UI_FOREGROUND:Int = 1100;
}

/* 
(UNFINISHED, MIGHT GET REMOVED DEPENDING ON HOW IMPLEMENTING Z-INDICES GOES)
Z-Ordering class

Technically a worse implementation than in something like V-Slice
but overall reduces boilerplate code due to not needing to make
a reordering function for every state 
    
Also provides some nice utility
*/
class Order extends FlxTypedGroup<FlxBasic>{
    public var layerMap:Map<Int, FlxTypedGroup<FlxBasic>> = [];

    public function addToLayer(layer:Int, object:FlxBasic, position:Int = 0):Void {
        var group:FlxTypedGroup<FlxBasic> = null;
        if (layerMap.exists(layer)) {
            group = layerMap.get(layer);
        }
        else {
            group = new FlxTypedGroup<FlxBasic>();
        }
        group.insert(position, object);
        layerMap.set(layer, group);
    }

    public function getLayer(layer:Int):FlxTypedGroup<FlxBasic> {
        if (layerMap.exists(layer)) {
            return layerMap.get(layer);
        }
        // Return an empty group instead of null? Might change it later
        return new FlxTypedGroup<FlxBasic>();
    }

    public function build(state:FlxState) {
        trace(layerMap);
        // layerMap.iterator().
        for (layer in layerMap.keys()) {
            trace(layer);
            add(layerMap[layer]);
        }
        state.add(this);
    }

    // public function reorder() {
    //     sort()
    // }

}