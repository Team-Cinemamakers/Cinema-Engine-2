package backend;

import backend.events.*;
import haxe.io.BytesData;
import openfl.events.Event;
import openfl.events.EventDispatcher;

class Conductor{
	// beats per minute
    public static var BPM:Float = 120;
	// time in milliseconds
    public static var TIME:Float = 0;
	// is conductor currently allowed to count up
    static var doConductorTime:Bool = false;

	// beat event to call on each beat and the event dispatcher for the event
    public static var mainBeatEvent:Event = new BeatEvent("beatEvent");
    public static var evDisp:EventDispatcher;

	// the current beat in the current song
    public static var curBeat:Int = 0;
	// the total song milliseconds when the last beat was hit
    static var lastBeatTime:Float = 0;

	// the calculated milliseconds between each beat
    static var beatVal:Float = (60/BPM) * 1000;

	// creates conductor (does this on main)
	public function new(startImedietally:Bool = false)
	{
		doConductorTime = startImedietally;
        evDisp = new EventDispatcher();
    }

	// plays conductor with bpm and also runs music play for playstate based on a bool value (this does not reset so it can be used after pause)
	public static function play(bpmNew:Float = 120, runMusicPlay:Bool = false)
	{
        BPM = bpmNew;
        doConductorTime = true;
        beatVal = (60/BPM) * 1000;
		if (runMusicPlay)
			MusicHandler.play();
    }

	// simply pauses the conductor
    public static function pause(){
        doConductorTime = false;
    }

	// resets conductor but does not stop or start it
	public static function reset(bpmNew:Float = 120, runMusicPlay:Bool = false)
	{
		BPM = bpmNew;
		beatVal = (60 / BPM) * 1000;
        TIME = 0;
        curBeat = 0;
        lastBeatTime = 0;
		if (runMusicPlay)
			MusicHandler.play();
    }

	// cancels conductor completely, resets all values and stops
    public static function cancel(){
        doConductorTime = false;
        TIME = 0;
        curBeat = 0;
        lastBeatTime = 0;
    }

	// sets a new bpm value for the conductor and calculates new time in between beats (in case of in song bpm changes)
    public static function setBPM(bpmNew:Float){
        BPM = bpmNew;
        beatVal = (60/BPM) * 1000;
    }

	// ran on update in the flxstate, adds the elapsed time to the conductor and then checks if music needs sync, also calculates curBeat
	public static function addConductorTime(elapsed:Float, state:FlxState)
	{
		if (FlxG.state == state)
		{
			if (doConductorTime)
			{
				TIME += elapsed * 1000;
				trace(TIME);
			}

			if (TIME >= lastBeatTime + beatVal)
			{
				curBeat++;
				lastBeatTime += beatVal;
				beatHit(curBeat);
			}
			if (FlxG.sound.music != null && !MusicHandler.playing)
			{
				if (FlxG.sound.music.time > TIME + 50 || FlxG.sound.music.time < TIME - 50)
					FlxG.sound.music.time = TIME;
			}
			else if (MusicHandler.inst != null && MusicHandler.voices != null && MusicHandler.playing)
			{
				MusicHandler.checkSync(TIME);
			}
		}
	}

	// runs every beat and dispatches the event to allow beatHit to run on FlxG States
    static function beatHit(beatNum:Int):Void{
        evDisp.dispatchEvent(mainBeatEvent);
    }
}