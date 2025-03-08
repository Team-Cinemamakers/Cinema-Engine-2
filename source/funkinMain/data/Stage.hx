package funkinMain.data;

import flixel.group.FlxSpriteGroup;

typedef StageFile = {
    var name:String;
    var objects:Array<StageObject>;
    var charData:Array<CharacterData>;
}

typedef CharacterData = {
    var name:String;
    var position:Array<Float>;
}

typedef StageObject = {
    var name:String;
    var path:String;
    var scale:Array<Float>;
    var position:Array<Float>;
    var animated:Bool;
    var animationData:Null<AnimationData>;
}

typedef AnimationData = {
    var name:String;
    var loop:Bool;
    var framerate:Float;
}

//boom, there goes your tower
class Stage extends FlxSpriteGroup
{
    public function new(){
        super(x,y);
    }
	public function load(stage:String):StageFile 
    {
        var json = JsonFunctions.loadJson("game/stages/" + stage);
		var mainStage:StageFile = cast(Json.parse(json));
        return mainStage;
    }
}
