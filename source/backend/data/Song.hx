package backend.data;

import openfl.Assets;

// FIXME: get this shit out of here when strumlines/notes/events are being properly worked on, HIGHLY wip
typedef Note =
{
	var time:Float; // time at which the note is supposed to be pressed
	var type:Int; // note type (0 for normal)
	var value:Int; // value (corresponds to the place in the strumline, so on 4k its from 0-3 and on 7k its from 0-6 and so on)
}

private typedef ChartEvent =
{
	var time:Float; // time at which the event occurs
	var values:Array<Dynamic>; // event values
}

private typedef ChartStrumline =
{
	var character:String;
	var notes:Array<Note>;
}

private typedef SongDefaults =
{
	var player:String;
	var opponent:String;
}

typedef SongFiles = {
    var inst:String;
    var vocals:String;
}

typedef SongMetadata =
{
	var name:String;
	var bpm:Float;
	var scrollSpeed:Float;
	var songFiles:SongFiles;
	// var strumLines:Array<MetaStrumline>; // TODO: not implemented yet
	var stage:String;
	// var characters; // TODO: not implemented yet
	var defaults:SongDefaults;
	// var scripts; // TODO: not implemented yet
}

typedef SongChart =
{
    var metadata:SongMetadata;
	var strumLines:Array<ChartStrumline>;
    var events:Array<ChartEvent>;
}

class Song
{
    public static function fromFile(song:String):SongChart {
        var jsonPath:String = Paths.json("game/songs/" + song + "/" + song);
        var rawJson = Assets.getText(jsonPath);

        var casted:SongChart = cast(Json.parse(rawJson));
        return casted;
    }
}
