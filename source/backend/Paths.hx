package backend;

import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.Assets;
import openfl.display.BitmapData;

/**
* Enum of sources for the path
*/
enum PathSource {
	/**
	* For base engine assets
	*/
	ENGINE; 

	/**
	* For the mod content assets
	*/
	CONTENT; 

	/**
	* For no source, idk what you would need it for ngl
	*/
	OTHER;
}

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

	// generic file
	public static function file(pth:String, directory:String = "", source:PathSource):String {
		if (directory != "") directory += "/";
		switch (source) {
			case ENGINE:
				return "assets/engine/" + directory + pth;
			case CONTENT:
				return "assets/content/" + directory + pth;
			default:
				return "assets/" + directory + pth;
		}
	}

	// png image
	public static function image(pth:String, directory:String = "", source:PathSource = PathSource.CONTENT):String
	{
		return file(pth, directory, source) + ".png";
	}

	// path for sound files, always ogg
	public static function audio(pth:String, directory:String = "", source:PathSource = PathSource.CONTENT):String
	{
		return file(pth, directory, source) + ".ogg";
	}

	// gets a json
	public static function json(pth:String, directory:String = "", source:PathSource = PathSource.CONTENT):String
	{
		return file(pth, directory, source) + ".json";
	}

	// gets an xml
	public static function xml(pth:String, directory:String = "", source:PathSource = PathSource.CONTENT):String
	{
		return file(pth, directory, source) + ".xml";
	}

	/*
		SPECIFIC ASSETS FUNCTIONS
	 */
	// get a sparrow atlas as frames for flxsprite
	public static function sparrow(pth:String, directory:String = "", source:PathSource = PathSource.CONTENT):FlxAtlasFrames
	{
		return flxanimate.frames.FlxAnimateFrames.fromSparrow(xml(pth, directory, source), bitmap(pth, directory, source));
	}

	// returns a bitmap from file, needed for flxanimate
	public static function bitmap(pth:String, directory:String = "", source:PathSource = PathSource.CONTENT):BitmapData
	{
		return BitmapData.fromFile(image(pth, directory, source));
	}

	/*
		SPECIALIZED ASSETS FUNCTIONS
	 */
	// get asset from a characters folder
	public static function char(pth:String, character:String):String
	{
		return file(pth, "characters/" + character, PathSource.CONTENT);
	}
}