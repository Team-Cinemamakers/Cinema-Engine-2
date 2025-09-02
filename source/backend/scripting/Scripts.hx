package backend.scripting;

import crowplexus.iris.Iris.IrisCall;
import funkin.data.Song;
import funkin.data.Stage;
import funkin.objects.Alphabet;

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

    public static function create(name:String, pth:String, directory:String = "", source:PathSource = PathSource.CONTENT, context:ScriptContext):HScript {
        if (Paths.exists(Paths.hscript(pth, directory, source))) {
            var script = new HScript(name, Paths.hscript(pth, directory, source), context);
            scripts[name] = script;
            return script;
        }
        return null;
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
        "JsonUtil" => JsonUtil,
        "MathUtil" => MathUtil,
        "SortUtil" => SortUtil,
        "ZLayers" => ZLayers,

        "Song" => Song,
        "Stage" => Stage,
        "Alphabet" => Alphabet,

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


