package source.backend;

#if !html5
import cpp.vm.Gc;
#end
import flixel.FlxGame;
import openfl.utils.Assets;

class CinemaGame extends flixel.FlxGame
{
    public override function switchState(){
        //clears all from assettracking
        AssetTracking.clearAll();
        #if !html5
        Gc.run(true);
        #end
        FlxG.bitmap.clearCache();
        FlxG.bitmapLog.clear();
        //gotta figure out how to fix this
        //if(FlxG.stage.context3D != null) FlxG.stage.context3D.dispose(true);
        super.switchState();
        draw();
    }
}