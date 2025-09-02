package backend;

class MusicHandler
{
	public static var inst:FlxSound;
	public static var voices:FlxSound;

	public static var playing:Bool = false;

	// loads the inst and voices for a song based on a song name
	public static function loadInstAndVoices(songName:String, instPath:String, vocalsPath:String):Void
	{
		inst = FlxG.sound.load(Paths.audio(instPath, 'songs/' + songName));
		voices = FlxG.sound.load(Paths.audio(vocalsPath, "songs/" + songName));
	}

	// plays the inst and voices while also instantly fixing the time in case of conductor pausing
	public static function play():Void
	{
		if (inst != null && voices != null)
		{
			inst.play();
			voices.play();
			playing = true;
		}
	}

	// shuts the music up them bitches needa be quiet
	public static function stop():Void
	{
		if (inst != null && voices != null)
		{
			inst.stop();
			voices.stop();
			playing = false;
		}
	}

	// pauses music but doesnt reset time idk
	public static function pause():Void
	{
		if (inst != null && voices != null)
		{
			inst.pause();
			voices.pause();
			playing = false;
		}
	}

	// checks if the voices is off sync from the inst
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

	public static function skipTime(time:Float):Void
	{
		if (inst.length < inst.time + time || voices.length < voices.time + time)
			return;

		inst.time += time;
		voices.time = inst.time;
		Conductor.TIME = inst.time;
	}
}
