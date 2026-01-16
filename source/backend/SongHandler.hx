package backend;

import openfl.events.Event;

class SongHandler
{
	public static var inst:FlxSound;
	public static var voices:FlxSound;

	public static var playing:Bool = false;
	public static var loaded:Bool = false;
	static var lod:Array<Bool> = [false, false];
	static var hasVocals:Bool = true;

	/**
		Loads the instrumental and vocals for a song by name.

		@param songName Name of the song
		@param instPath Name of the instrumental track
		@param vocalsPath Name of the vocals track
	**/
	public static function load(songName:String, instPath:String, vocalsPath:String, tempDir:String = ""):Void
	{
		loaded = false;
		//if it is a ce2 file it'll set the PCs temp directory, which if it exists, it will stream audio from there instead of loading an embedded sound :3
		if(tempDir != ""){
			trace('Loading song from temp directory: ' + tempDir);
			inst = FlxG.sound.load(null, 1, false, null, false, false, tempDir + instPath + '.ogg');
			voices = FlxG.sound.load(null, 1, false, null, false, false, tempDir + vocalsPath + '.ogg');
		} else {
			inst = FlxG.sound.load(Paths.audio(instPath, 'songs/' + songName), 1, false, null, false, false, null, null, function() {
				lod[0] = true;
			});
			voices = FlxG.sound.load(Paths.audio(vocalsPath, "songs/" + songName), 1, false, null, false, false, null, null, function() {
				lod[1] = true;
			});
		}
		if(vocalsPath == "") hasVocals = false;
	}

	/**
		Plays instrumental and vocals.
	**/
	public static function play():Void
	{
		if (inst != null)
		{
			trace("start play");
			inst.play();
			if(voices != null){
				voices.time = inst.time;
				voices.play();
			}
			playing = true;
			Conductor.play();

			if(!inst.playing) trace("why the fuck aren't you playing");
			if(loaded) trace("it's loaded though");
		}
	}

	/**
		Stops the song completely.
	**/
	public static function stop():Void
	{
		if (inst != null)
		{
			Conductor.stop();
			playing = false;
			inst.stop();
			if(voices != null) voices.stop();
			
		}
	}

	/**
		Pauses the song.
	**/
	@:access(flixel.sound.FlxSound)
	public static function pause():Void
	{
		if (inst != null)
		{
			Conductor.pause();
			playing = false;
			inst.pause();
			if(voices != null) voices.pause();
		}
	}

	/**
		Checks if the vocals are offsync from the instrumental and corrects it if they are.
	**/
	public static function checkSync():Void
	{
		if(!playing || inst == null) return;
		if (voices != null)
		{
			if (!MathUtil.isInRange(voices.time, inst.time, 50))
			{
				voices.time = inst.time;
			}
		}
	}

	public static function update():Void
	{
		if((lod[0] && lod[1]) || (lod[0] && !hasVocals)){
			loaded = true;
		}
	}

	public static function forceSync():Void
	{
		if(!playing || inst == null) return;
		if(playing && inst != null && inst.time == 0)
		{
			play();
		}
		if (voices != null)
		{
			voices.time = inst.time;
		}
	}

	/**
		Skips time by specified amount in milliseconds.

		@param time Amount to skip by
	**/
	public static function skipTime(time:Float):Void
	{
		if (inst.length < inst.time + time || voices.length < voices.time + time)
			return;

		inst.time += time;
		voices.time = inst.time;
		Conductor.TIME = inst.time;
	}
}
