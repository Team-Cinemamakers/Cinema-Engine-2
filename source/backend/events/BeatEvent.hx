package backend.events;

import openfl.events.EventType;

class BeatEvent extends openfl.events.Event
{
	public static inline var BEAT_HIT:EventType<BeatEvent> = "beatHit";
    
    public function new(label:String){
        super(label);
    }
}