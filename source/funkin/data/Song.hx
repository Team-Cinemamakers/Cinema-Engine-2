package funkin.data;

import funkin.data.SongEvent.SongEventData;
import funkin.objects.Strumline.StrumlineData;
import funkin.objects.Strumline.StrumlineInfo;
import funkin.states.PlayState;

typedef SongCharacter =
{
	var name:String;
	var character:String;
	var positionMarker:String;
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
	var characters:Array<SongCharacter>;
	// var scripts; // TODO: not implemented yet
}

typedef SongData =
{
	var info:SongInfo;
	var strumlines:Array<StrumlineData>; // Each strumline contains its own chart for that strumline only
	var events:Array<SongEventData>;
}

class Song
{
	public var info:SongInfo;
	public var strumlines:Array<StrumlineData>;
	public var events:Array<SongEventData>;

	// Maybe temporary?
	public function new(song:String, directory:String = "") {
		var song = Song.fromFile(song, directory);

		this.info = song.info;
		trace(info);
		this.strumlines = song.strumlines;
		this.events = song.events;
	}

	/**
		Get metadata for a character from the chart file.

		@param charName Name of the character as specified in the chart
	**/
	public function getCharacterMetadata(charName:String):SongCharacter {
		trace(charName);
		trace(info.characters);
		for (char in info.characters) {
			if (char.name == charName) return char;
		}
		return null;
	}

	/**
		Get song data from a file.

		@param song Name of the song
		@param directory Directory that the song is located in
	**/
	public static function fromFile(song:String, directory:String = ""):SongData
	{
        var rawJson = JsonUtil.loadJson(Paths.json("songs/" + song + "/" + song, directory));
		var casted:SongData = cast(Json.parse(rawJson));
		return casted;
    }
}
