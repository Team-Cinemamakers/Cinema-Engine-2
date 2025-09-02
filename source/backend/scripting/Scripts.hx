package backend.scripting;

import crowplexus.iris.Iris.IrisCall;
import funkin.data.Song;
import funkin.data.Stage;
import funkin.objects.Alphabet;
import funkin.objects.Transition;

enum ScriptContext {
    ANY; // Not a context, but is used for signifying that any context is fine
    STATE;
    CHARACTER;
    STAGE;
    SONG;
    EVENT;
    OTHER;
}

/**
    Manager for all the HScript scripts
**/
class Scripts {
    public static var scripts:Map<String, HScript> = [];

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

    public static function remove(name:String):Void {
        if (scripts.exists(name)) 
        {
            scripts.get(name).destroy();
            scripts.remove(name);
            
        }
    }

    /**
        Returns default libraries
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

        "Conductor" => Conductor,
        "Paths" => Paths,
        "PathSource" => PathSource,
        "JsonUtil" => JsonUtil,
        "MathUtil" => MathUtil,
        "SortUtil" => SortUtil,
        "ZLayers" => ZLayers,
        "CoolInput" => CoolInput,
        "ScrollableMenu" => ScrollableMenu,
        "MusicHandler" => MusicHandler,
        "Globals" => Globals,

        "Song" => Song,
        "Stage" => Stage,
        "Alphabet" => Alphabet,
        "Transition" => Transition,

        "PlayState" => PlayState.instance

    ];

    /**
        Sets a variable for all scripts. Optionally you can specify a context that the scripts need in order to qualify.
    **/
    public static function setForScripts(variable:String, argument:Dynamic, requireContext:ScriptContext = ScriptContext.ANY) {
        for (script in scripts) {
            if (script.context == requireContext && requireContext != ScriptContext.ANY) script.set(variable, argument);
        }
    }

    /**
        Calls a function from all scripts and returns their callbacks as a Map. Optionally you can specify a context that the scripts need in order to qualify.
    **/
    public static function callOnScripts(func:String, args:Array<Dynamic>, requireContext:ScriptContext = ScriptContext.ANY):Map<String, IrisCall> {
        var calls:Map<String, IrisCall> = [];

        for (name => script in scripts) {
            if (script.context == requireContext && requireContext != ScriptContext.ANY) calls[name] = script.run(func, args);
        }

        return calls;
    }
}


