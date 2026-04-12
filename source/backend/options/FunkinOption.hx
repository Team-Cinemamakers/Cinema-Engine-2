package backend.options;


import haxe.macro.Expr.ComplexType;

enum OptionType {
    INT;
    FLOAT;
    BOOL;
    ENUM;
}

class FunkinOption {
    public var name:String;
    public var type:ComplexType;
    @:isVar public var value(get, set):Dynamic;
    public var min:Dynamic = -1;
    public var max:Dynamic = -1;
    public var options:Array<Dynamic> = [];
    public var enumType:OptionType;

    public function new (name:String, type:String, defaultValue:Dynamic, ?min:Dynamic, ?max:Dynamic, ?options:Array<Dynamic>) {
        this.name = name;
        this.type = TPath({ pack: [], name: type });
        this.value = defaultValue;
        if (min != null) this.min = min;
        if (max != null) this.max = max;
        if (options != null) this.options = options;

        if(type == "Int") enumType = OptionType.INT;
        else if(type == "Float") enumType = OptionType.FLOAT;
        else if(type == "Bool") enumType = OptionType.BOOL;
        else if(options != null && options.length > 0) enumType = OptionType.ENUM;
    }

    function get_value():Dynamic {
        #if !macro
        if(FlxG.save != null){
            if(FlxG.save.data.options == null) FlxG.save.data.options = new Map<String, Dynamic>();
            if(!FlxG.save.data.options.exists(name)){
                FlxG.save.data.options.set(name, this.value);
            } else {
                this.value = FlxG.save.data.options.get(name);
            }
        }
        #end
        return this.value;
    }

    function set_value(v:Dynamic):Dynamic {
        #if !macro
        if(FlxG.save != null){
            if(FlxG.save.data.options == null) FlxG.save.data.options = new Map<String, Dynamic>();
            FlxG.save.data.options.set(name, v);
        }        
        #end
        this.value = v;
        return this.value;
    }
}