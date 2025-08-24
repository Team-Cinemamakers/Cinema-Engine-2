package backend;

import backend.events.*;
import openfl.events.Event;
import openfl.events.EventDispatcher;

class Conductor
{
	public static var BPM:Float = 120; // beats per minute
	public static var TIME:Float = 0; // time in milliseconds

	static var doConductorTime:Bool = false; // is conductor currently allowed to count up

	public static var evDisp:EventDispatcher; // event dispatcher
	public static var beatEvent:Event = new BeatEvent(BeatEvent.BEAT_HIT); // beat event to call on each beat and the event dispatcher for the event
	public static var stepEvent:Event = new StepEvent(StepEvent.STEP_HIT); // step event to call on each step and the event dispatcher for the event

	public static var curBeat:Int = 0; // the current beat in the current song
	static var lastBeatTime:Float = 0; // the total song milliseconds when the last beat was hit

	public static var curStep:Int = 0; // the current step in the current song
	static var lastStepTime:Float = 0; // the total song milliseconds when the last step was hit

	static var beatTime:Float = (60 / BPM) * 1000; // the calculated milliseconds between each beat
	static var stepTime:Float = beatTime / 4; // the calculated milliseconds between each step // TODO: support time signatures LMAOO

	// creates conductor (does this on main)
	public function new(startImmediately:Bool = false)
	{
		doConductorTime = startImmediately;
		evDisp = new EventDispatcher();
	}

	// plays conductor with bpm and also runs music play for playstate based on a bool value (this does not reset so it can be used after pause)
	public static function start(bpmNew:Float = 120, runMusicPlay:Bool = false)
	{
		BPM = bpmNew;
		doConductorTime = true;
		beatTime = (60 / BPM) * 1000;
		stepTime = beatTime / 4;
		if (runMusicPlay)
			MusicHandler.play();
	}

	// pauses the conductor
	public static function pause()
	{
		doConductorTime = false;
	}

	// resets conductor but does not stop or start it
	public static function reset(bpmNew:Float = 120, runMusicPlay:Bool = false)
	{
		if (runMusicPlay)
			MusicHandler.play();

		BPM = bpmNew;
		beatTime = (60 / BPM) * 1000;
		stepTime = beatTime / 4;
		TIME = 0;

		curBeat = 0;
		lastBeatTime = 0;
		curStep = 0;
		lastStepTime = 0;
	}

	// stops conductor completely and resets all values
	public static function stop()
	{
		doConductorTime = false;
		TIME = 0;

		curBeat = 0;
		lastBeatTime = 0;
		curStep = 0;
		lastStepTime = 0;
	}

	// sets a new bpm value for the conductor and calculates new time in between beats (in case of in song bpm changes)
	public static function setBPM(bpmNew:Float)
	{
		BPM = bpmNew;
		beatTime = (60 / BPM) * 1000;
		stepTime = beatTime / 4;
	}

	// ran on update in the flxstate, adds the elapsed time to the conductor and then checks if music needs sync, also calculates curBeat
	public static function setConductorTime(timeNew:Float, state:FlxState)
	{
		if (doConductorTime)
		{
			TIME = timeNew;
			trace(TIME);
		}

		if (TIME >= lastBeatTime + beatTime) // beat hits
		{
			curBeat++;
			lastBeatTime += beatTime;
			beatHit(curBeat);
		}

		if (TIME >= lastStepTime + stepTime)
		{
			curStep++;
			lastStepTime += stepTime;
			stepHit(curStep);
		}

		else if (MusicHandler.inst != null && MusicHandler.voices != null && MusicHandler.playing)
		{
			MusicHandler.checkSync();
		}
	}

	static function stepHit(stepNum:Int):Void
	{
		evDisp.dispatchEvent(stepEvent);
	}

	// runs every beat and dispatches the event to allow beatHit to run on FlxG States
	static function beatHit(beatNum:Int):Void
	{
		evDisp.dispatchEvent(beatEvent);
	}
}
