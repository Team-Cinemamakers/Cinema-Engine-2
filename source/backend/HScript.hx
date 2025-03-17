package backend;

import crowplexus.iris.Iris;
import crowplexus.iris.IrisConfig;
import openfl.Assets;

class HScriptManager {
    public static var scripts:Array<HScript> = [];

    public static function load(name:String, path:String, autoRun:Bool = false) {
        var script = new HScript(name, path, autoRun);

        script.setVars();

        scripts.push(script);
        return script;
    }

}

class HScript extends Iris {
    var rules:IrisConfig;

    public function new(name:String, path:String, autoRun:Bool = false) {
        this.rules = new IrisConfig(name, autoRun);
        
        super(Assets.getText(Paths.script(path)), this.rules);

        if (!rules.autoRun) execute();
    }


    public function run(func:String, args:Array<Dynamic> = null) {
        if (args == null) args = [];

        return call(func, args);
    }

    public function setVars() {
        set('FlxG', flixel.FlxG);
		set('FlxMath', flixel.math.FlxMath);
		set('FlxSprite', flixel.FlxSprite);
		set('FlxCamera', flixel.FlxCamera);
		set('FlxTimer', flixel.util.FlxTimer);
		set('FlxTween', flixel.tweens.FlxTween);
		set('FlxEase', flixel.tweens.FlxEase);
		set('FlxColor', FlxColor.colorLookup);

        set("Conductor", Conductor);
        set("CoolInput", CoolInput);
        set("MathFunctions", MathFunctions);
        set("Paths", Paths);
        set("ZOrder", ZOrder);

        set("PlayState", PlayState.instance);
    }
}