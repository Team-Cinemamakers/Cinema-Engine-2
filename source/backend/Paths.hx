package backend;

import openfl.Assets;

class Paths
{
    //this was literally just done as a proof of concept does not support animated sprites at all yet
    public static function char(pth:String, isAtlas:Bool = false):String{
        if(isAtlas){
            return "assets/images/characters/atlas/" + pth + ".png";
        } else {
            return "assets/images/characters/spritesheet/" + pth + ".png";
        }
    }

    public static function stateAssets(pth:String):String{
        return "assets/images/stateAssets/" + pth + ".png";
    }

    public static function music(pth:String):String{
        return "assets/audio/music/" + pth + ".ogg";
    }

    public static function sound(pth:String):String{
        return "assets/audio/sound/" + pth + ".ogg";
    }
	public static function json(pth:String):String
	{
		return "assets/data/" + pth + ".json";
	}
}