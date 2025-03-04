package backend;

import haxe.macro.Expr.TypeDefinition;

class JsonFunctions
{
	// loads a json and returns its string
    public static function loadJson(jsonPath:String):String{
        var jsonVal = File.getContent(Paths.json(jsonPath));
		return jsonVal;
	}
}