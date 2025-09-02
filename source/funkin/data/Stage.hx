package funkin.data;

import flixel.animation.FlxBaseAnimation;
import flixel.group.FlxSpriteGroup;

typedef StageFile = {
    var name:String;
    var objects:Array<StageObject>;
    var markers:Array<StageMarkerData>;
}

typedef StageMarkerData = {
    var name:String;
    var position:Array<Float>;
}

typedef StageObject = {
    var name:String;
    var file:String;
    var position:Array<Float>;
    var scale:Null<Array<Float>>;
    var flipX:Null<Bool>;
    var zIndex:Null<Int>;
    
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

class Stage extends FlxTypedGroup<FlxBasic>
{
    public var data:StageFile;
    public var currentStage:String = 'stage';

    public var script:HScript = null;

	public function new(stage:String) 
    {
        super();

        this.currentStage = stage;

        var json = JsonUtil.loadJson(Paths.json(stage, "stages/" + stage));
		var stage:StageFile = cast(Json.parse(json));

        // SET DEFAULTS FOR UNSPECIFIED
        for (object in stage.objects) {
            if (object.scale == null) object.scale = [1, 1];
            if (object.flipX == null) object.flipX = false;
            if (object.zIndex == null) object.zIndex = 0;

            if (object.animations != null) {
                for (animation in object.animations) {
                    if (animation.flipX == null) animation.flipX = false;
                }
            }
        }

        this.data = stage;

        setupScripting();

        // CALLBACK: onCreate
        if (script != null)
            script.run('onCreate');
    }

    public function build(){
        // CALLBACK: onStageBuild
        if (script != null)
            script.run('onStageBuild');

		for(i in 0...data.objects.length){
			var obj:StageObject = data.objects[i];

            // CALLBACK: onStageBuildObject
            if (script != null)
                script.run('onStageBuildObject', [obj]);

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

                stageSprite.zIndex = obj.zIndex;

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

        // CALLBACK: onStageBuildEnd
        if (script != null)
            script.run('onStageBuildEnd');

        SortUtil.reorder(this);
	}

    public function getPositionFromMarker(markerName:String):FlxPoint {
        for (marker in data.markers) {
            if (marker.name == markerName) return new FlxPoint(marker.position[0], marker.position[1]);
        }
        return new FlxPoint();
    }

    function setupScripting() {
		// Initiate character script
		if (Paths.exists(Paths.hscript(currentStage, "stages/" + currentStage))) {
			script = Scripts.create(currentStage + "-stage", currentStage, "stages/" + currentStage, ScriptContext.STAGE);

            script.set("add", add);
            script.set("remove", remove);
            script.set("getPositionFromMarker", getPositionFromMarker);

			script.set("stage", this);
		}
	}
}
