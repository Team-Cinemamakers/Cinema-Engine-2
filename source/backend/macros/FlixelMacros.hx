package backend.macros;
#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
#end

// Macros are confusing as fuck

class FlixelMacros {
    public static macro function buildFlxBasic():Array<Field> {
        var fields:Array<Field> = Context.getBuildFields();

        fields.push({
            name: "zIndex",
            access: [Access.APublic],
            kind: FVar(macro:Int, macro $v{0}),
            pos: Context.currentPos()
        });

        Context.info(fields, Context.currentPos());

        return fields;
    }
}