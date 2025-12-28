package backend;

class SongHandler
{
	public static var inst:FlxSound;
	public static var voices:FlxSound;

	public static var playing:Bool = false;

	/**
		Loads the instrumental and vocals for a song by name.

		@param songName Name of the song
		@param instPath Name of the instrumental track
		@param vocalsPath Name of the vocals track
	**/
	public static function load(songName:String, instPath:String, vocalsPath:String, tempDir:String = ""):Void
	{
		if(tempDir != ""){
			trace('Loading song from temp directory: ' + tempDir);
			inst = FlxG.sound.load(null, 1, false, null, false, false, tempDir + instPath + '.ogg');
			voices = FlxG.sound.load(null, 1, false, null, false, false, tempDir + vocalsPath + '.ogg');
		} else {
			inst = FlxG.sound.load(Paths.audio(instPath, 'songs/' + songName));
			voices = FlxG.sound.load(Paths.audio(vocalsPath, "songs/" + songName));
		}
	}

	/**
		Plays instrumental and vocals.
	**/
	public static function play():Void
	{
		if (inst != null && voices != null)
		{
			inst.play();
			voices.play();
			playing = true;
		}
	}

	/**
		Stops the song completely.
	**/
	public static function stop():Void
	{
		if (inst != null && voices != null)
		{
			inst.stop();
			voices.stop();
			playing = false;
		}
	}

	/**
		Pauses the song.
	**/
	public static function pause():Void
	{
		if (inst != null && voices != null)
		{
			inst.pause();
			voices.pause();
			playing = false;
		}
	}

	/**
		Checks if the vocals are offsync from the instrumental, and fixes them if they are.
	**/
	public static function checkSync():Void
	{
		if (voices != null)
		{
			if (!MathUtil.isInRange(voices.time, inst.time, 50))
			{
				voices.time = inst.time;
			}
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
