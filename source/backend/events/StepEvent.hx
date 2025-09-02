package backend.events;

import openfl.events.EventType;

class StepEvent extends openfl.events.Event
{
	public static inline var STEP_HIT:EventType<StepEvent> = "stepHit";
    
    public function new(label:String){
        super(label);
    }
}