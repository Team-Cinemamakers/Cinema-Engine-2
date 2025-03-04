package backend;

import backend.events.*;
import haxe.io.BytesData;
import openfl.events.Event;
import openfl.events.EventDispatcher;

class Conductor{
    public static var BPM:Float = 120;
    public static var TIME:Float = 0;
    static var doConductorTime:Bool = false;

    public static var mainBeatEvent:Event = new BeatEvent("beatEvent");
    public static var evDisp:EventDispatcher;

    public static var curBeat:Int = 0;
    static var lastBeatTime:Float = 0;

    static var beatVal:Float = (60/BPM) * 1000;

    var onBeat:Array<Dynamic> = [];

    public function new(startImmedietally:Bool = false){
        doConductorTime = startImmedietally;
        evDisp = new EventDispatcher();
    }

	public static function play(bpmNew:Float = 120, runMusicPlay:Bool = false)
	{
        BPM = bpmNew;
        doConductorTime = true;
        beatVal = (60/BPM) * 1000;
		if (runMusicPlay)
			MusicHandler.play();
    }

    public static function pause(){
        doConductorTime = false;
    }

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

    public static function cancel(){
        doConductorTime = false;
        TIME = 0;
        curBeat = 0;
        lastBeatTime = 0;
    }

    public static function setBPM(bpmNew:Float){
        BPM = bpmNew;
        beatVal = (60/BPM) * 1000;
    }

	public static function addConductorTime(elapsed:Float, state:FlxState)
	{
		if (FlxG.state == state)
		{
			if (doConductorTime)
			{
				TIME += elapsed * 1000;
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
				MusicHandler.checkSync();
			}
		}
	}

    static function beatHit(beatNum:Int):Void{
        evDisp.dispatchEvent(mainBeatEvent);
    }
}