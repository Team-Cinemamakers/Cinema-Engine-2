package backend.scripting;

import crowplexus.iris.Iris.IrisCall;
import flixel.util.FlxAxes;
import funkin.data.Song;
import funkin.data.Stage;
import funkin.objects.Alphabet;
import funkin.objects.Bar;
import funkin.objects.Transition;
import funkin.states.PlayState;

enum ScriptContext {
    ANY; // Not a context, but is used for signifying that any context is fine
    STATE;
    CHARACTER;
    STAGE;
    SONG;
    EVENT;
    HUD;
    OTHER;
}

enum EventProcess {
    CONTINUE; // Continue the event without any changes
    CANCEL; // Cancel the event
}

/**
    Manager for all the HScript scripts
**/
class Scripts {
    public static var scripts:Map<String, HScript> = [];

    /**
        Creates and returns a new script.

        @param name Name of the script
        @param pth Full path to the script file
        @param context Context of what the script is (State script, Character script, etc.)

        @return New script
    **/
    public static function create(name:String, pth:String, context:ScriptContext):HScript {
        if (Paths.exists(pth)) {
            // Check in case its a duplicate to prevent loading a shit ton of the same scripts. Might replace with a better solution later
            remove(name);

            var script = new HScript(name, pth, context);
            scripts.set(name,script);
            return script;
        }
        return null;
    }

    /**
        Removes and destroys a script by name.

        @param name Name of the script to be destroyed
    **/
    public static function remove(name:String):Void {
        if (scripts.exists(name)) 
        {
            scripts.get(name).destroy();
            scripts.remove(name);
            
        }
    }

    /**
        Returns default libraries.
    **/
    public static function getDefaults():Map<String, Dynamic> return [
        "Std" => Std,
        "Math" => Math,

        "FlxG" => FlxG,
        "FlxMath" => FlxMath,
        "FlxSprite" => FlxSprite,
        "FlxCamera" => FlxCamera,
        "FlxTimer" => FlxTimer,
        "FlxTween" => FlxTween,
        "FlxEase" => FlxEase,
        "FlxColor" => FlxColor.colorLookup,
        "FlxTypedGroup" => FlxTypedGroup,
        "FlxAxes" => MacroUtil.buildAbstract(FlxAxes),

        "Conductor" => Conductor,
        "Paths" => Paths,
        "PathSource" => PathSource,
        "JsonUtil" => JsonUtil,
        "MathUtil" => MathUtil,
        "SortUtil" => SortUtil,
        "ZLayers" => ZLayers,
        "CoolInput" => CoolInput,
        "ScrollableMenu" => ScrollableMenu,
        "MusicHandler" => SongHandler,
        "Globals" => Globals,
        "EventProcess" => EventProcess,
        "PlayState" => PlayState,

        "Song" => Song,
        "Stage" => Stage,
        "Alphabet" => Alphabet,
        "Transition" => Transition,
        "Bar" => Bar,
    ];

    /**
        Sets a variable for all scripts. Optionally you can specify a context that the scripts need in order to qualify.

        @param variable Name by which the variable should be accessed
        @param argument The variable itself
        @param requireContext (Optional) Context requirement. The script must have this context in order to get the variable
    **/
    public static function setForScripts(variable:String, argument:Dynamic, requireContext:ScriptContext = ScriptContext.ANY):Void {
        for (script in scripts) {
            if (script.context == requireContext || requireContext == ScriptContext.ANY) script.set(variable, argument);
        }
    }

    /**
        Calls a function from all scripts and returns their callbacks as a Map. Optionally you can specify a context that the scripts need in order to qualify.

        @param func Name of the function to be called
        @param args (Optional) Array of arguments to pass to the function
        @param requireContext (Optional) Context requirement. The script must have this context in order to get the variable

        @returns Map containing all callbacks from the scripts, accessible by script name
    **/
    public static function callOnScripts(func:String, args:Array<Dynamic>, requireContext:ScriptContext = ScriptContext.ANY):Map<String, IrisCall> {
        var calls:Map<String, IrisCall> = [];

        for (name => script in scripts) {
            if (script.context == requireContext || requireContext == ScriptContext.ANY) calls.set(name, script.run(func, args));
        }

        return calls;
    }

    /**
        Determines whether the event should proceed or be cancelled based on calls received from `callOnScripts`

        @param calls Map<String, IrisCall> that you should have from `callOnScripts`

        @returns Whether the event should continue (`EventProcess.CONTINUE`) or be cancelled (`EventProcess.CANCEL`)
    **/
    public static function getCallEventResult(calls:Map<String, IrisCall>):EventProcess {
        for (result in calls) {
            if (result != null && result.returnValue == EventProcess.CANCEL) return EventProcess.CANCEL;
        }
        return EventProcess.CONTINUE;
    }
}


