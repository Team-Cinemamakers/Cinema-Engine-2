package backend.options;

import haxe.macro.Expr.ComplexType;

class FunkinOption {
    public var name:String;
    public var type:ComplexType;
    public var value:Dynamic;
    public var min:Dynamic = -1;
    public var max:Dynamic = -1;
    public var options:Array<Dynamic> = [];

    public function new (name:String, type:String, defaultValue:Dynamic, ?min:Dynamic, ?max:Dynamic, ?options:Array<Dynamic>) {
        this.name = name;
        this.type = TPath({ pack: [], name: type });
        this.value = defaultValue;
        if (min != null) this.min = min;
        if (max != null) this.max = max;
        if (options != null) this.options = options;
    }
}