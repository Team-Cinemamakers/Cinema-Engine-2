package backend;

import openfl.Assets;

class Paths
{
    // self-explanatory
	public static function exists(pth:String):Bool {
        return Assets.exists(pth);
    }

	// this was literally just done as a proof of concept does not support animated sprites at all yet
	public static function char(pth:String, isAtlas:Bool = false):String
	{
		if (isAtlas)
		{
			return "assets/images/characters/atlas/" + pth + ".png";
		}
		else
		{
			return "assets/images/characters/spritesheet/" + pth + ".png";
		}
	}

	// path for state specific asset folder
	public static function stateImage(pth:String):String
	{
		return image("stateAssets/" + pth);
	}

	// png image
	public static function image(pth:String):String
	{
		return "assets/images/" + pth + ".png";
	}

	// moosic lol, always ogg
	public static function music(pth:String):String
	{
		return "assets/audio/music/" + pth + ".ogg";
	}

	// path for sound files, always ogg
	public static function sound(pth:String):String
	{
		return "assets/audio/sound/" + pth + ".ogg";
	}

	// gets a json from the data folder
	public static function json(pth:String):String
	{
		return "assets/data/" + pth + ".json";
	}
}
