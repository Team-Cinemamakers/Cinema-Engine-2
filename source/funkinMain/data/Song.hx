package funkinMain.data;

import funkinMain.data.SongEvent.SongEventData;
import funkinMain.objects.Strumline.StrumlineData;
import funkinMain.objects.Strumline.StrumlineInfo;
import funkinMain.states.PlayState;

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
	var strumlines:Array<StrumlineData>; // each strumline contains its own chart for that strumline only
	var events:Array<SongEventData>;
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
