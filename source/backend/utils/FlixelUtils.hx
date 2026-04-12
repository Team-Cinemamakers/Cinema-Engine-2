package backend.utils;

import backend.options.Options;
import flixel.FlxBasic;

class FlixelUtils extends FlxBasic
{
    public override function update(elapsed:Float):Void {
        super.update(elapsed);
        if(Options.FPS != null){
            if(Options.FPS != FlxG.drawFramerate || Options.FPS != FlxG.updateFramerate){
                FlxG.drawFramerate = Options.FPS;
                FlxG.updateFramerate = Options.FPS;
            } 
        }
    }
}