package backend;

import backend.optimization.BitmapVCache;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import lime.graphics.Image;
import openfl.Assets;
import openfl.display.BitmapData;
@:access(openfl.display.BitmapData)

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
	// Self-explanatory
	public static function exists(pth:String):Bool
	{
		return Assets.exists(pth);
	}

	/**
		Returns a path to any file specified.

		@param pth Name of the file
		@param directory Directory that the file is located in
		@param source Source of the file (Content/Engine/Other)
	**/
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

	/**
		Returns a path to a specified PNG file.

		@param pth Name of the file (Without the extension)
		@param directory Directory that the file is located in
		@param source Source of the file (Content/Engine/Other)
	**/
	public static function image(pth:String, directory:String = "", source:PathSource = PathSource.CONTENT):String
	{
		return file(pth, directory, source) + ".png";
	}

	/**
		Returns a path to a specified OGG file.

		@param pth Name of the file (Without the extension)
		@param directory Directory that the file is located in
		@param source Source of the file (Content/Engine/Other)
	**/	
	public static function audio(pth:String, directory:String = "", source:PathSource = PathSource.CONTENT):String
	{
		return file(pth, directory, source) + ".ogg";
	}

	/**
		Returns a path to a specified JSON file.

		@param pth Name of the file (Without the extension)
		@param directory Directory that the file is located in
		@param source Source of the file (Content/Engine/Other)
	**/	
	public static function json(pth:String, directory:String = "", source:PathSource = PathSource.CONTENT):String
	{
		return file(pth, directory, source) + ".json";
	}

	/**
		Returns a path to a specified XML file.

		@param pth Name of the file (Without the extension)
		@param directory Directory that the file is located in
		@param source Source of the file (Content/Engine/Other)
	**/
	public static function xml(pth:String, directory:String = "", source:PathSource = PathSource.CONTENT):String
	{
		return file(pth, directory, source) + ".xml";
	}

	/**
		Returns a path to a specified HScript file.

		@param pth Name of the file (Without the extension)
		@param directory Directory that the file is located in
		@param source Source of the file (Content/Engine/Other)
	**/
	public static function hscript(pth:String, directory:String = "", source:PathSource = PathSource.CONTENT):String
	{
		return file(pth, directory, source) + ".hxs";
	}

	/*
		SPECIFIC ASSETS FUNCTIONS
	 */
	/**
		Returns a specified path as sparrow atlas frames.

		@param pth Name of the atlas (Without the extension)
		@param directory Directory that the atlas is located in
		@param source Source of the atlas (Content/Engine/Other)
	**/
	public static function sparrow(pth:String, directory:String = "", source:PathSource = PathSource.CONTENT, ?sprite:FlxSprite = null, ?keep:Bool = true):FlxAtlasFrames
	{
		if(sprite != null) sprite.cacheKey = xml(pth, directory, source);
		return AssetTracking.getAtlas(xml(pth, directory, source), bitmap(pth, directory, source), keep);
		//return flxanimate.frames.FlxAnimateFrames.fromSparrow(xml(pth, directory, source), bitmap(pth, directory, source));
	}

	/**
		Returns a specified PNG file as a Bitmap.

		@param pth Name of the file (Without the extension)
		@param directory Directory that the file is located in
		@param source Source of the file (Content/Engine/Other)
	**/
	public static function bitmap(pth:String, directory:String = "", source:PathSource = PathSource.CONTENT):BitmapData
	{
		if(AssetTracking.useVCache){
			var bm = new BitmapVCache(0, 0, true, 0);
			bm.__fromImage(Image.fromFile(image(pth, directory, source)));
			return(bm);
		}
		return BitmapData.fromFile(image(pth, directory, source));
	}
}