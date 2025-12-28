package source.backend;

import cpp.vm.Gc;
import flixel.FlxGame;
import openfl.utils.Assets;

class CinemaGame extends flixel.FlxGame
{
    public override function switchState(){
        //Clears all openfl asset cache (planning on removing this completely soon)
        //Assets.cache.clear();
        //clears all from assettracking
        AssetTracking.clearAll();
        Gc.run(true);
        FlxG.bitmap.clearCache();
        FlxG.bitmapLog.clear();
        super.switchState();
        draw();
    }
}