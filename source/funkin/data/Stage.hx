package funkin.data;

import flixel.group.FlxSpriteGroup;

typedef StageFile = {
    var name:String;
    var objects:Array<StageObject>;
    var characters:Array<StageCharacterData>;
}

typedef StageCharacterData = {
    var name:String;
    var position:Array<Float>;
}

typedef StageObject = {
    var name:String;
    var file:String;
    var position:Array<Float>;
    var scale:Null<Array<Float>>;
    var flipX:Null<Bool>;
    
    var animations:Null<Array<StageObjectAnimationData>>; // if its null then obviously animated is false
    var defaultAnimation:Null<String>;
    var frameSize:Null<Array<Int>>; // would be used for stuff like spritesheets that arent atlases

}

typedef StageObjectAnimationData = {
    var name:String;
    var loop:Bool;
    var framerate:Float;
    var flipX:Null<Bool>;

    var prefix:Null<String>; // for prefix 
    var indices:Null<Array<Int>>; // for indices
}

class Stage extends FlxSpriteGroup
{
    public var data:StageFile;
	public function new(stage:String) 
    {
        super();

        var json = JsonFunctions.loadJson(Paths.json(stage, "stages/" + stage));
		var stage:StageFile = cast(Json.parse(json));

        // SET DEFAULTS FOR UNSPECIFIED
        for (object in stage.objects) {
            if (object.scale == null) object.scale = [1, 1];
            if (object.flipX == null) object.flipX = false;

            if (object.animations != null) {
                for (animation in object.animations) {
                    if (animation.flipX == null) animation.flipX = false;
                }
            }
        }

        this.data = stage;
    }

    public function build(){
		for(i in 0...data.objects.length){
			var obj:StageObject = data.objects[i];
            var spritePath:String = Paths.image(obj.file, "stages/" + data.name + "/assets");
			if(Paths.exists(spritePath)){
				var stageSprite:FlxSprite = new FlxSprite();
                
                // loading
                if (obj.animations != null) {
                    if (obj.frameSize != null) // non-atlas spritesheet
                        stageSprite.loadGraphic(spritePath, true, obj.frameSize[0], obj.frameSize[1]);
                    else // sparrow atlas
                        stageSprite.frames = Paths.sparrow(obj.file, "stages/" + data.name + "/assets");
                }
                else // no animations, just plain sprite
                    stageSprite.loadGraphic(spritePath);

				stageSprite.scale.set(obj.scale[0], obj.scale[1]);
				stageSprite.updateHitbox();

				stageSprite.x = obj.position[0];
				stageSprite.y = obj.position[1];

                // if it has animations
                if (obj.animations != null) {
                    for (anim in obj.animations) {
                        if (anim.prefix != null && anim.indices != null) // indices with prefix
                            stageSprite.animation.addByIndices(anim.name, anim.prefix, anim.indices, "", anim.framerate, anim.loop, anim.flipX);
                        else if (anim.prefix != null) // only uses prefix
                            stageSprite.animation.addByPrefix(anim.name, anim.prefix, anim.framerate, anim.loop, anim.flipX);
                        else if (anim.indices != null) // only uses indices
                            stageSprite.animation.add(anim.name, anim.indices, anim.framerate, anim.loop, anim.flipX);
                    }

                    // if default animation then play it immediately
                    if (obj.defaultAnimation != null)
                        stageSprite.animation.play(obj.defaultAnimation, true);
                }

				add(stageSprite);
			} else {
				trace("Couldn't find asset at: " + spritePath);
			}
		}
	}
}
