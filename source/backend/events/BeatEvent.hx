package backend.events;

import openfl.events.EventType;

class BeatEvent extends openfl.events.Event
{
	public static inline var BEAT_HIT:EventType<BeatEvent> = "beatHit";
    
	// beat event which is called cuz yea
    public function new(label:String){
        super(label);
    }
}