package backend;

class MusicHandler{
    public static var inst:FlxSound;
    public static var voices:FlxSound;

    public static var playing:Bool = false;

	// loads the inst and voices for a song based on a song name
	public static function loadInstAndVoices(songName:String, instPath:String, vocalsPath:String)
	{
		inst = FlxG.sound.load(Paths.audio('game/songs/' + songName + "/" + instPath));
		voices = FlxG.sound.load(Paths.audio('game/songs/' + songName + "/" + vocalsPath));
    }

	// plays the inst and voices while also instantly fixing the time in case of conductor pausing
    public static function play(){
        if(inst != null && voices != null){
            inst.play();
            voices.play();
			playing = true;
        }
    }

	// shuts the music up them bitches needa be quiet
    public static function stop(){
        if(inst != null && voices != null){
            inst.stop();
            voices.stop();
            playing = false;
        }
    }

	// pauses music but doesnt reset time idk
    public static function pause(){
        if(inst != null && voices != null){
            inst.pause();
            voices.pause();
            playing = false;
        }
	}
	// checks if the inst or voices are offsync and then fixes it, called each update on conductor
	public static function checkSync(time:Float)
	{
		if (time < inst.time - 50 || time > inst.time + 50 || time < voices.time - 50 || time > voices.time + 50)
		{
			inst.time = time;
			voices.time = time;
		}
    }
}