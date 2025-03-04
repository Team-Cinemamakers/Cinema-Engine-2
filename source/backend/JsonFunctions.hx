package backend;

import openfl.Assets;

class JsonFunctions
{
	// loads a json and returns its string
    public static function loadJson(jsonPath:String):String{
		var jsonVal = Assets.getText(Paths.json(jsonPath));
		return jsonVal;
	}
}