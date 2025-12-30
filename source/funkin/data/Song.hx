package funkin.data;

import backend.utils.CE2FileUtil;
import funkin.data.SongEvent.SongEventData;
import funkin.objects.Strumline.StrumlineData;
import funkin.objects.Strumline.StrumlineInfo;
import funkin.states.PlayState;
import haxe.io.Bytes;
import haxe.zip.Entry;
import haxe.zip.Reader;
#if !html5
import sys.FileSystem;
import sys.io.File;
#end

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
	var stages:Array<String>;
	var hud:String;
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
	public var events:Array<SongEvent> = [];
	public var tempDir:String = "";

	// Maybe temporary?
	public function new(songDir:String, directory:String = "") {
		var song:SongData;
		tempDir = "";
		#if desktop
		if(CE2FileUtil.doesCE2FileExist('assets/content/songs/${songDir}.ce2')) {
			var unzippedFile:Array<String> = CE2FileUtil.unzipCE2SongFile(songDir);
			if(unzippedFile.length == 0) {
				throw 'Failed to unzip CE2 song file for song: ' + songDir;
			} else {
				song = cast(Json.parse(unzippedFile[0]));
				tempDir = unzippedFile[1];
			}
		} else {
			song = Song.fromFile(songDir, directory);
		}
		#else
		song = Song.fromFile(songDir, directory);
		#end

		this.info = song.info;
		this.strumlines = song.strumlines;
		
		var eventDefinitions = song.events;
		for (eventDef in eventDefinitions) {
			var event = new SongEvent(eventDef.name, eventDef.time, eventDef.values);
			events.push(event);
		}
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

		@param songDir Name of the song
		@param directory Directory that the song is located in
	**/
	public static function fromFile(songDir:String, directory:String = ""):SongData
	{
        var rawJson = JsonUtil.loadJson(Paths.json("songs/" + songDir + "/" + songDir, directory));
		var casted:SongData = cast(Json.parse(rawJson));
		return casted;
    }
}
