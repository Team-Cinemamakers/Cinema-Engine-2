package funkinMain.data;

import funkinMain.objects.Strumline.StrumlineData;
import funkinMain.objects.Strumline.StrumlineInfo;

// FIXME: get this shit out of here when events are being properly worked on, HIGHLY wip
typedef EventData =
{
	var time:Float; // time at which the event occurs
	var values:Array<Dynamic>; // event values
}

typedef SongDefaults =
{
	var player:String;
	var opponent:String;
}

typedef SongTracks =
{
    var inst:String;
    var vocals:String;
}

typedef SongInfo =
{
	var name:String;
	var bpm:Float;
	var scrollSpeed:Float;
	var songFiles:SongTracks;
	var strumlines:Array<StrumlineInfo>;
	var stage:String;
	// var characters; // TODO: not implemented yet
	var defaults:SongDefaults;
	// var scripts; // TODO: not implemented yet
}

typedef SongData =
{
	var metadata:SongInfo;
	var strumlines:Array<StrumlineData>;
	var events:Array<EventData>;
}

class Song
{
	public static function fromFile(song:String):SongData
	{
        var rawJson = JsonFunctions.loadJson("game/songs/" + song + "/" + song);
		var casted:SongData = cast(Json.parse(rawJson));
        return casted;
    }
}
