package backend;

import haxe.macro.Expr.TypeDefinition;

class JsonFunctions
{

    public static function loadJson(jsonPath:String):String{
        var jsonVal = File.getContent(Paths.json(jsonPath));
        var json:String = Json.parse(jsonVal);
        return json;
    }

}