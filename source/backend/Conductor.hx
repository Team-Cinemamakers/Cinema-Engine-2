package backend;

import backend.events.*;
import openfl.events.Event;
import openfl.events.EventDispatcher;

class Conductor
{
	public static var BPM:Float = 120; // Beats per minute
	public static var TIME:Float = 0; // Time in milliseconds

	static var doConductorTime:Bool = false; // Is conductor currently allowed to count up

	public static var evDisp:EventDispatcher; // Event dispatcher
	public static var beatEvent:Event = new BeatEvent(BeatEvent.BEAT_HIT); // Beat event to call on each beat
	public static var stepEvent:Event = new StepEvent(StepEvent.STEP_HIT); // Step event to call on each step

	public static var curBeat:Int = 0; // The current beat
	static var lastBeatTime:Float = 0; // Time in milliseconds when the last beat was hit

	public static var curStep:Int = 0; // The current step
	static var lastStepTime:Float = 0; // Time in milliseconds when the last step occurred

	static var beatTime:Float = (60 / BPM) * 1000; // The calculated milliseconds between each beat
	static var stepTime:Float = beatTime / 4; // The calculated milliseconds between each step // TODO: support time signatures LMAOO

	/**
		Creates a conductor.

		This is done by default in Main, and usually there is no need to make another one.

		@param startImmediately Whether the conductor should start counting up immediately
	**/
	public function new(startImmediately:Bool = false)
	{
		doConductorTime = startImmediately;
		evDisp = new EventDispatcher();
	}

	/**
		Starts/resumes the conductor. Optionally makes the song play.

		@param newBpm New BPM for the Conductor
		@param playSong Make the song play
	**/
	public static function start(bpmNew:Float = 120, playSong:Bool = false):Void
	{
		BPM = bpmNew;
		doConductorTime = true;
		beatTime = (60 / BPM) * 1000;
		stepTime = beatTime / 4;
		if (playSong)
			SongHandler.play();
	}

	/**
		Pauses the conductor time.
	**/
	public static function pause():Void
	{
		doConductorTime = false;
	}

	/**
		Plays the conductor time.
	**/
	public static function play():Void
	{
		doConductorTime = true;
	}

	/**
		Reset all conductor values, but notably does not start or stop it.

		@param newBpm New BPM for the Conductor
		@param playSong Make the song play
	**/
	public static function reset(newBpm:Float = 120, playSong:Bool = false):Void
	{
		BPM = newBpm;
		beatTime = (60 / BPM) * 1000;
		stepTime = beatTime / 4;
		TIME = 0;

		curBeat = 0;
		lastBeatTime = 0;
		curStep = 0;
		lastStepTime = 0;

		if (playSong)
			SongHandler.play();
	}

	/**
		Stops the conductor entirely, resetting all values to 0.
	**/
	public static function stop():Void
	{
		doConductorTime = false;
		TIME = 0;

		curBeat = 0;
		lastBeatTime = 0;
		curStep = 0;
		lastStepTime = 0;
	}

	/**
		Sets a new BPM for the conductor, and calculates new beat and step times.

		@param newBpm New BPM
	**/
	public static function setBPM(newBpm:Float):Void
	{
		BPM = newBpm;
		beatTime = (60 / BPM) * 1000;
		stepTime = beatTime / 4;
	}

	/**
		Updates the conductor time, calling any beat or step events in the process.

		@param newTime New time the conductor should be on
	**/
	public static function setConductorTime(newTime:Float):Void
	{
		if (doConductorTime)
		{
			TIME = newTime;
		}

		if (TIME >= lastBeatTime + beatTime) // Beat hits
		{
			curBeat++;
			lastBeatTime += beatTime;
			evDisp.dispatchEvent(beatEvent);
		}

		if (TIME >= lastStepTime + stepTime) // Step hits
		{
			curStep++;
			lastStepTime += stepTime;
			evDisp.dispatchEvent(stepEvent);
		}

		else if (SongHandler.inst != null && SongHandler.voices != null && SongHandler.playing)
		{
			SongHandler.checkSync();
		}
	}
}
