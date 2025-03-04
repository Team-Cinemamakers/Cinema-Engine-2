package funkinMain.objects;

typedef CharacterFile = {
    var name:String;
    var icon:String;
    var offset:Array<Int>;
    var fileName:String;
    var animations:Array<CharacterAnimation>;
}

typedef CharacterAnimation = {
    var name:String;
    var prefix:Null<String>;
    var indices:Null<Array<Int>>;
    var offset:Array<Int>;
    var fps:Int;
    var loop:Bool;
}

class Character extends FlxSprite {
    var name:String; // display name of the character in places like chart editor
    var icon:String;
    var positionOffset:FlxPoint; // same as offset in the char file // slippery slope -x8c8r
    var fileName:String;
    var animations:Map<String, CharacterAnimation>;

    public function new(character:String, x:Float = 0, y:Float = 0) {
        super(x, y);
        
        this.fileName = character;

        var file = load(character);
        
        this.name = file.name;
        this.icon = file.icon;
        this.positionOffset = new FlxPoint(file.offset[0], file.offset[1]);

        frames = Paths.sparrow(Paths.char(fileName));
        
        for (anim in file.animations) {
            if (anim.indices != null)
                animation.addByIndices(anim.name, anim.prefix, anim.indices, "", anim.fps, anim.loop);
            else
                animation.addByPrefix(anim.name, anim.prefix, anim.fps, anim.loop);
        }

        trace(animation.getNameList());
    }

    function load(character) {
        var rawJson = JsonFunctions.loadJson(Paths.char(character));
        var casted:CharacterFile = cast(Json.parse(rawJson));
        return casted;
    }
}