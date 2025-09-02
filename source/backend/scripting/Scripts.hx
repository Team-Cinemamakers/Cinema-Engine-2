package backend.scripting;

import funkin.data.Song;
import funkin.data.Stage;
import funkin.objects.Alphabet;

enum ScriptContext {
    STATE;
    CHARACTER;
    STAGE;
    SONG;
    EVENT;
}

/**
    Manager for all the HScript scripts
**/
class Scripts {
    public static var scripts:Map<String, HScript> = [];

    public static function create(name:String, pth:String, directory:String = "", source:PathSource = PathSource.CONTENT):HScript {
        if (Paths.exists(Paths.hscript(pth, directory, source))) {
            var script = new HScript(name, Paths.hscript(pth, directory, source));
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
}


