package backend.scripting;

import flixel.FlxSubState;

class HScriptState extends FlxSubState {
    var script:HScript;

    public function new(name:String, path:String) {
        super();

        setupScripting(name, path);

        // CALLBACK: create
        if (script != null)
            script.run("create");
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        // CALLBACK: preUpdate
        if (script != null)
            script.run("preUpdate", [elapsed]);

        // Auto-update conductor to reduce boilerplate on custom states
        if(FlxG.sound.music != null){
            Conductor.setConductorTime(FlxG.sound.music.time, this);
        }

        // CALLBACK: update
        if (script != null)
            script.run("update", [elapsed]);
    }

    override function destroy() {
        // CALLBACK: preDestroy
        if (script != null)
            script.run("preDestroy");
        
        super.destroy();

        // CALLBACK: destroy
        if (script != null)
            script.run("destroy");

        Scripts.remove(script.name);
    }

    function setupScripting(name:String, path:String) {
        // Initiate state script
        if (Paths.exists(path)) {
            script = Scripts.create('$name-state', path, ScriptContext.STATE);

            script.set("add", add);
            script.set("remove", remove);
            script.set("this", this);
        }
    }
}