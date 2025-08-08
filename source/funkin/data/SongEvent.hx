package funkin.data;

typedef SongEventData =
{
    var name:String; // event name/id, cant be repeated between multiple events for obvious reasons
	var time:Float; // time at which the event occurs
	var values:Array<SongEventValue>; // event values
}

typedef SongEventValue = {
    var name:String;
    var value:Dynamic;
}

typedef SongEventFileValue = {
    var name:String;
    var description:String;
    var type:String; // manually specified type: "float", "string", "bool", "color" etc
    var optional:Bool;
}

typedef SongEventFile = {
    var name:String; // event name/id
    var description:String; // event description in the chart editor
    var values:Array<SongEventFileValue>;
}

class SongEvent {
    public static function fromFile(eventName:String, directory:String):SongEventFile
	{
        var rawJson = JsonFunctions.loadJson(Paths.json("events/" + eventName, directory));
		var casted:SongEventFile = cast(Json.parse(rawJson));
        return casted;
    }
}