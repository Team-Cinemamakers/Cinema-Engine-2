package backend.options;

import backend.options.FunkinOption;
import backend.options.FunkinOption;
import backend.options.OptionsData;
import haxe.Json;
import sys.io.File;
#if !macro
import flixel.FlxG;
#end
#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
#end

class OptionsGenerator {
    public static macro function build():Array<Field> {
        trace("Generating options...");
        var fields = Context.getBuildFields();
        var content = File.getContent("assets/engine/data/options/options.json");
        var data:Array<OptionsData> = Json.parse(content);
        var pos = Context.currentPos();

        var funkinOptionType = TPath({ pack: ["backend", "options"], name: "FunkinOption" });
        var optionsList = [];

        for (i in 0...data.length) {
            var item = data[i];
            var type = TPath({ pack: [], name: item.type });
            
            var storageName = "_" + item.name;
            fields.push({
                name: storageName,
                access: [APublic, AStatic],
                kind: FVar(funkinOptionType, macro new backend.options.FunkinOption($v{item.name}, $v{item.type}, $v{item.defaultValue}, $v{item.min}, $v{item.max}, $v{item.options})),
                pos: pos
            });

            fields.push({
                name: item.name,
                access: [APublic, AStatic],
                kind: FProp("get", "set", type),
                pos: pos
            });

            fields.push({
                name: "get_" + item.name,
                access: [APrivate, AInline, AStatic],
                kind: FFun({
                    args: [],
                    ret: type,
                    expr: macro {
                        #if !macro
                        if(FlxG.save.data.options == null) FlxG.save.data.options = new Map<String, Dynamic>();
                        if(FlxG.save.data.options[name] == null){
                            FlxG.save.data.options[name] = $i{storageName}.value;
                        } else {
                            $i{storageName}.value = FlxG.save.data.options[name];
                        }
                        #end
                        return $i{storageName}.value;
                    }
                }),
                pos: pos
            });

            fields.push({
                name: "set_" + item.name,
                access: [APrivate, AInline, AStatic],
                kind: FFun({
                    args: [{ name: "v", type: type }],
                    ret: type,
                    expr: macro {
                        #if !macro
                        if(FlxG.save.data.options == null) FlxG.save.data.options = new Map<String, Dynamic>();
                        FlxG.save.data.options[name] = v;
                        #end
                        $i{storageName}.value = v;
                        return $i{storageName}.value;
                    }
                }),
                pos: pos
            });

            optionsList.push(macro $i{storageName});

            trace("Generated option: " + item.name + " of type " + item.type);
        }

            fields.push({
                name: "getAllOptions",
                access: [APublic, AStatic],
                kind: FFun({
                    args: [],
                    ret: TPath({ pack: [], name: "Array", params: [TPType(funkinOptionType)] }),
                    expr: macro {
                        return $a{optionsList};
                    }
                }),
                pos: pos
            });

        return fields;
    }
}