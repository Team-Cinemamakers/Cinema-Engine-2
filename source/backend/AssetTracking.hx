package backend;

import flixel.graphics.FlxGraphic;

@:access(openfl.display.BitmapData)
class AssetTracking{
    static var protectedAssets:Array<FlxGraphic> = [];

    //tbh i took a bit of this shit from psych bc really there isnt a better way to do it anyway
    //RUN THIS AS FALSE UNLESS YOU DONT NEED ANY GRAPHICS SAVED, run as true at the beginning of the state, if you run this mid state you're fucked
    //Need to set up easy system to add assets to protected assets on creation
    @:access(flixel.system.frontEnds.BitmapFrontEnd._cache)
    public static function destroyUnusedAssets(noProtection:Bool = false){
        if(noProtection) protectedAssets = [];

		for (key in FlxG.bitmap._cache.keys())
            {
                //this was just working I changed nothing now it isnt because haxe hates me so ts broken now
                //if (protectedAssets.contains(key)) return;

                var asset:FlxGraphic = FlxG.bitmap.get(key);
                
                if (asset != null && asset.bitmap != null && asset.bitmap.__texture != null)
                    asset.bitmap.__texture.dispose();
                FlxG.bitmap.remove(asset);
            }
            #if desktop
            Gc.run(true);
            #end
    }

    public static function addAsset(yup:FlxGraphic){
        if(!protectedAssets.contains(yup)) protectedAssets.push(yup);
    }

    public static function removeAsset(yup:FlxGraphic){
        if(!protectedAssets.contains(yup)) protectedAssets.remove(yup);
    }
}