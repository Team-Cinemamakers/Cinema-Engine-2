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
	// checks if the voices is off sync from the inst
	public static function checkSync()
	{
        if(voices != null){
            if(!MathFunctions.isInRange(voices.time, inst.time, 50)){
                voices.time = inst.time;
                PlayState.resyncNotes();
            }
        }
    }

    public static function skipTime(time:Float){
        if(inst.length < inst.time + time || voices.length < voices.time + time) return;

        inst.time += time;
        voices.time = inst.time;
        PlayState.resyncNotes();
    }
}