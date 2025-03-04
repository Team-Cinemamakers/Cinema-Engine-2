package backend;

class MusicHandler{
    public static var inst:FlxSound;
    public static var voices:FlxSound;

    public static var playing:Bool = false;

    public static function loadInstAndVoices(songName:String){
        if(inst == null){
            inst = new FlxSound().loadEmbedded('assets/audio/songs/' + songName + "/Inst.ogg");
        } else {
            inst.loadEmbedded('assets/audio/songs/' + songName + "/Inst.ogg");
        }
        if(voices == null){
            voices = new FlxSound().loadEmbedded('assets/audio/songs/' + songName + "/Voices.ogg");
        } else {
            voices.loadEmbedded('assets/audio/songs/' + songName + "/Voices.ogg");
        }
    }

    public static function play(){
        if(inst != null && voices != null){
            inst.play();
            voices.play();
            playing = true;

            inst.time = Conductor.TIME;
            voices.time = Conductor.TIME;
        }
    }

    public static function stop(){
        if(inst != null && voices != null){
            inst.stop();
            voices.stop();
            playing = false;
        }
    }

    public static function pause(){
        if(inst != null && voices != null){
            inst.pause();
            voices.pause();
            playing = false;
        }
    }

    public static function checkSync(){
        if(Conductor.TIME < inst.time - 100 || Conductor.TIME > inst.time + 100 || Conductor.TIME < voices.time - 100 || Conductor.TIME > voices.time + 100){
            inst.time = voices.time = Conductor.TIME;
        }
    }
}