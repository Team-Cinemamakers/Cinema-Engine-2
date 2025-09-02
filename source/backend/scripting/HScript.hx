package backend.scripting;

import crowplexus.iris.Iris;
import crowplexus.iris.IrisConfig;
import openfl.Assets;

class HScript extends Iris {

    public var context:ScriptContext;

    public function new(name:String, path:String, context:ScriptContext) {
        var code:String = Assets.getText(path);

        var irisConfig:IrisConfig = new IrisConfig(name);

        super(code, irisConfig);
        
        // Initiate defaults
        for (k => v in Scripts.getDefaults()) {
            set(k, v);
        }        
    }

    /**
       Wrapper for the default call function so it doesn't error out in case a function is called when it wasn't defined 
        @param fun Name of the function you want to run
        @param args (Optional) Arguments to be passed to the function
        @param undefinedWarn (Optional) Traces a message in case the function you tried to run wasn't defined
        @return Result of the call
    **/
    public function run(fun:String, ?args:Array<Dynamic>, ?undefinedWarn:Bool = false):IrisCall {
        if (args == null) args = [];

        var func = get(fun);
        if (func != null && Reflect.isFunction(func)) {
            return call(fun, args);
        }
        else if (undefinedWarn) {
            trace('Function "${fun}" was not defined in script "${name}" before being called');
        }
        return null;
    }
}