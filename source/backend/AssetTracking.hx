package backend;

import cpp.vm.Gc;
import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flxanimate.frames.FlxAnimateFrames;
import haxe.ds.StringMap;
import openfl.Assets;
import openfl.display.BitmapData;
//so this fucking sucked, now flxsprite automatically (when running loadGraphic) gets the graphic from here so there aren't duplicates :D cut down 3/4 MB usage in some places, goated
class AssetTracking
{
    public static var graphics:StringMap<TrackedGraphic> = new StringMap();

    //we get the pre-existing flxgraphic (or set it)
    public static function get(path:String, keep:Bool = true):FlxGraphic
    {
        //if graphic exists already, load it
        if (graphics.exists(path))
        {
            //add 1 to the amount of current references
            graphics.get(path).references++;
             //return graphic so flxsprite can still do its thing
            return graphics.get(path).graphic;
        }
        //else we get the bitmap data, make the flxgraphic, and return it :3
        var bitmap:BitmapData = Assets.getBitmapData(path);
        //set cache key to "", set cache to false since we're doing it here
        var graphic = FlxGraphic.fromBitmapData(bitmap, false, "", false);

        //graphic should not persist nor destroy on no use (because for some reason it insta-destroys it)
        graphic.persist = true;
        graphic.destroyOnNoUse = false;
        graphic.bitmap = null;

        bitmap = null;
        //set it :3 or not
        if(keep) graphics.set(path, new TrackedGraphic(graphic));
        //return graphic so flxsprite can still do its thing
        return graphic;
    }

    //same thing but for atlas, almost everything is the same, called when using Paths.sparrow() for simplicities sake
    public static function getAtlas(xmlPath:String, bitmapData:BitmapData, ?keep:Bool = true):FlxAtlasFrames
    {
        var key = xmlPath;

        if (graphics.exists(key))
        {
            graphics.get(key).references++;
            //returns the FlxAtlasFrames
            return graphics.get(key).frames;
        }
        trace('Loading atlas: ' + xmlPath);

        var graphic = FlxGraphic.fromBitmapData(bitmapData, false, "", false);

        graphic.persist = true;
        graphic.destroyOnNoUse = false;
        graphic.bitmap = null;

        //get FlxAtlasFrames from a sparrow, same as you would normally
        var frames:FlxAtlasFrames = FlxAnimateFrames.fromSparrow(xmlPath, bitmapData);

        var tracked = new TrackedGraphic(graphic, frames);
        tracked.frames = frames;

        if(keep) graphics.set(key, tracked);

        bitmapData = null;

        //returns the FlxAtlasFrames
        return frames;
    }

    //called when an FlxSprite is destroyed, simply checks if its still cached and if it is, removes an instance. Clears the cache if all instances are gone.
    public static function release(path:String):Void
    {
        if (!graphics.exists(path)) return;

        var tracked = graphics.get(path);
        tracked.references--;

        if (tracked.references <= 0)
        {
            tracked.graphic.destroy();
            graphics.remove(path);
        }
    }

    //Simply runs through all assets in graphics, destroys them, and then completely clears the map.
    public static function clearAll():Void
    {
        for (path in graphics.keys())
        {
            var tracked = graphics.get(path);
            tracked.graphic.destroy();
        }
        graphics.clear();
    }

    //runs gc lol, done when a cached asset is cleared.
    public static function gcClean():Void{
        Gc.run(true);
    }
}

//tracked graphic class, holds
class TrackedGraphic
{
    public var graphic:FlxGraphic;
    public var frames:FlxAtlasFrames;
    public var references:Int = 1;

    public function new(graphic:FlxGraphic, ?frames:FlxAtlasFrames)
    {
        this.graphic = graphic;
        if(frames != null) this.frames = frames;
    }
}