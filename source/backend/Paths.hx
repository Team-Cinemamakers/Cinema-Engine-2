package backend;

import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.Assets;
import openfl.display.BitmapData;

class Paths
{
	/*
		GENERIC ASSET FUNCTIONS
		To use specify the exact path from the "assets" folder (sans extension... hehe... sans)
	 */
	// self-explanatory
	public static function exists(pth:String):Bool
	{
		return Assets.exists(pth);
	}

	// png image
	public static function image(pth:String):String
	{
		return "assets/" + pth + ".png";
	}

	// path for sound files, always ogg
	public static function audio(pth:String):String
	{
		return "assets/" + pth + ".ogg";
	}
	// gets a json
	public static function json(pth:String):String
	{
		return "assets/" + pth + ".json";
	}

	// gets an xml
	public static function xml(pth:String):String
	{
		return "assets/" + pth + ".xml";
	}

	/*
		SPECIFIC ASSETS FUNCTIONS
	 */
	// get a sparrow atlas as frames for flxsprite
	public static function sparrow(pth:String):FlxAtlasFrames
	{
		return flxanimate.frames.FlxAnimateFrames.fromSparrow(xml(pth), bitmap(pth));
	}

	// returns a bitmap from file, needed for flxanimate
	public static function bitmap(pth:String):BitmapData
	{
		return BitmapData.fromFile(image(pth));
	}

	/*
		SPECIALIZED ASSETS FUNCTIONS
	 */
	// get asset from a characters folder
	public static function char(pth:String):String
	{
		return "game/characters/" + pth + "/" + pth;
	}

	// path for state specific asset folder
	public static function stateImage(pth:String):String
	{
		return image("images/stateAssets/" + pth);
	}
}
