package funkin.data;

typedef SongEventData =
{
    var name:String; // event name/id, cant be repeated between multiple events for obvious reasons
	var time:Float; // time at which the event occurs
	var values:Array<SongEventValue>; // event values
}

typedef SongEventValue = {
    var name:String;
    var value:Dynamic;
}

typedef SongEventValueDef = {
    var name:String;
    var description:String;
    var type:String; // manually specified type: "float", "string", "bool", "color" etc
    var optional:Bool;
}

typedef SongEventFile = {
    var name:String; // event name/id
    var description:String; // event description in the chart editor
    var values:Array<SongEventValueDef>;
}

class SongEvent {
    public var name:String;
    public var values:Map<String, Dynamic> = [];
    public var time:Float;
    public var triggered:Bool = false; // Whether the event was already triggered
    public var script:HScript;

    public function new(eventName:String, time:Float, values:Array<SongEventValue>) {
        this.name = eventName;
        this.time = time;

        for (value in values) {
            this.values.set(value.name, value.value);
        }

        setupScripting();
    }

    /**
        Gets a value from the event.

        @param valueName Name of the value
        
        @return Value, null if it doesn't exist
    **/
    public function getValue(valueName:String):Dynamic {
        if (values.exists(valueName)) return values.get(valueName);
        else {
            trace('Value "$valueName" doesn\' exist in event "$name"!');
            return null;
        }
    }

    function setupScripting() {
		// Initiate event script
		if (Paths.exists(Paths.hscript(name, "events"))) {
			script = Scripts.create(name + "-event", Paths.hscript(name, "events"), ScriptContext.EVENT);
		}
	}

    /**
        Triggers the event.
    **/
    public function trigger() {
        triggered = true;
        
        Scripts.callOnScripts(name, [values]);
        // CALLBACK: eventTriggered
        if (script != null)
            script.run(name, [values]);
    }
}