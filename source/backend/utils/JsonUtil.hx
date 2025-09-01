package backend.utils;

import openfl.Assets;

/**
	Collection of JSON-related functions
**/
class JsonUtil
{
	/**
		Loads a JSON file and returns its contents as a string

		@param jsonPath Path to the JSON file

		@returns Contents of the JSON file
	**/
	public static function loadJson(jsonPath:String):String
	{
		var jsonVal = Assets.getText(jsonPath);
		return jsonVal;
	}
}
