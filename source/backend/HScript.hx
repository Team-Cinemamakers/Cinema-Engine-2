package backend;

import crowplexus.iris.Iris;
import crowplexus.iris.IrisConfig;
import openfl.Assets;

class HScript {
    var rules:IrisConfig;
    var script:Iris;

    public function new(name:String, autoRun:Bool = false) {
        this.rules = new IrisConfig(name, autoRun);
    }

    public function load(pth:String) {
        script = new Iris(Assets.getText(Paths.script(pth)), rules);

        script.set("ZOrder", ZOrder);
        script.set("FlxSprite", FlxSprite);
        script.set("FlxColor", FlxColor.colorLookup);

        if (!rules.autoRun) script.execute();
    }

    public function run(func:String, args:Array<Dynamic> = null) {
        if (args == null) args = [];

        return script.call(func, args);
    }
}