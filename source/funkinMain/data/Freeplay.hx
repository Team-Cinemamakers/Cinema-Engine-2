package funkinMain.data;

typedef FreeplayData = {
    var sections:Array<SectionData>;
}

typedef SectionData = {
    var name:String;
    var songs:Array<FreeplaySongData>;
}
typedef FreeplaySongData = {
    var name:String;
    var displayName:String;
    var difficulties:Array<String>;
    var icon:String;
}

class Freeplay
{
	public static function loadFreeplay():FreeplayData
	{
        var rawJson = JsonFunctions.loadJson("game/Freeplay");
		var casted:FreeplayData = cast(Json.parse(rawJson));
		return casted;
    }
}
