package funkin.data;

import flixel.animation.FlxBaseAnimation;
import flixel.group.FlxSpriteGroup;

typedef StageFile = {
    var name:String;
    var objects:Array<StageObject>;
    var markers:Array<StageMarkerData>;
    var baseZoom:Null<Float>;
}

typedef StageMarkerData = {
    var name:String;
    var position:Array<Float>;
}

typedef StageObject = {
    var name:String;
    var stage:String;
    var file:String;
    var position:Array<Float>;
    var scale:Null<Array<Float>>;
    var scrollFactor:Null<Array<Float>>;
    var flipX:Null<Bool>;
    var zIndex:Null<Int>;
    
    var animations:Null<Array<StageObjectAnimationData>>; // If its null then obviously animated is false
    var defaultAnimation:Null<String>;
    var frameSize:Null<Array<Int>>; // Would be used for stuff like spritesheets that arent atlases

}

typedef StageObjectAnimationData = {
    var stage:String;
    var loop:Bool;
    var framerate:Float;
    var flipX:Null<Bool>;

    var prefix:Null<String>; // For prefix 
    var indices:Null<Array<Int>>; // For indices
}

class Stage
{
    public var data:StageFile;
    public var objects:Map<String, FlxSprite> = [];
    public var stage:String = 'stage';

    public var script:HScript = null;

	public function new(stage:String) 
    {
        this.stage = stage;

        var json = JsonUtil.loadJson(Paths.json(stage, "stages/" + stage));
		var stage:StageFile = cast(Json.parse(json));

        // SET DEFAULTS FOR UNSPECIFIED

        if (stage.baseZoom == null) stage.baseZoom = 0.85;

        for (object in stage.objects) {
            if (object.scale == null) object.scale = [1, 1];
            if (object.scrollFactor == null) object.scrollFactor = [1, 1];
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

        // CALLBACK: create
        if (script != null)
            script.run('create');
    }

    /**
        Builds the current stage from the stage file
    **/
    public function build(?state:FlxState){
        state ??= FlxG.state;

        // CALLBACK: stageBuild
        if (script != null)
            script.run('stageBuild');

		for(i in 0...data.objects.length){
			var obj:StageObject = data.objects[i];

            // CALLBACK: stageBuildObject
            if (script != null)
                script.run('stageBuildObject', [obj]);

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

                stageSprite.scrollFactor.set(obj.scrollFactor[0], obj.scrollFactor[1]);

                stageSprite.zIndex = obj.zIndex;

                // if it has animations
                if (obj.animations != null) {
                    for (anim in obj.animations) {
                        if (anim.prefix != null && anim.indices != null) // indices with prefix
                            stageSprite.animation.addByIndices(anim.stage, anim.prefix, anim.indices, "", anim.framerate, anim.loop, anim.flipX);
                        else if (anim.prefix != null) // only uses prefix
                            stageSprite.animation.addByPrefix(anim.stage, anim.prefix, anim.framerate, anim.loop, anim.flipX);
                        else if (anim.indices != null) // only uses indices
                            stageSprite.animation.add(anim.stage, anim.indices, anim.framerate, anim.loop, anim.flipX);
                    }

                    // if default animation then play it immediately
                    if (obj.defaultAnimation != null)
                        stageSprite.animation.play(obj.defaultAnimation, true);
                }

                objects.set(obj.name, stageSprite);
				state.add(stageSprite);
			} else {
				trace("Couldn't find asset at: " + spritePath);
			}
		}

        // CALLBACK: stageBuildEnd
        if (script != null)
            script.run('stageBuildEnd');
	}

    /**
        Gets a position from a specified position marker if defined in the stage file.

        @param markerstage stage of the marker
        
        @returns An FlxPoint containing the marker's position
    **/
    public function getPositionFromMarker(markerName:String):FlxPoint {
        for (marker in data.markers) {
            if (marker.name == markerName) return new FlxPoint(marker.position[0], marker.position[1]);
        }
        return new FlxPoint();
    }

    function setupScripting() {
		// Initiate character script
		if (Paths.exists(Paths.hscript(stage, "stages/" + stage))) {
			script = Scripts.create(stage + "-stage", Paths.hscript(stage, "stages/" + stage), ScriptContext.STAGE);

            script.set("add", add);
            script.set("delete", delete);
            script.set("remove", remove);
            script.set("getPositionFromMarker", getPositionFromMarker);
            script.set("get", get);

			script.set("stage", this);
            trace('Added stage HScript!');
		}
	}

    /**
        Sets visibility of the stage.

        @param visible Whether the stage is visible or invisible
    **/
    public function setVisibility(visible:Bool):Void {
        for (object in objects) {
            object.visible = visible;
        }
    }

    /**
        Adds object to the stage.

        @param name Name under which the object should be added
        @param object The object itself
    **/
    public function add(name:String, object:FlxSprite):Void {
        objects.set(name, object);
    }

    /**
        Gets an object from the stage.

        @param name Name of the object
    **/    
    public function get(name:String):FlxSprite {
        if (objects.exists(name)) {
            return objects.get(name);
        }
        return new FlxSprite().makeGraphic(16, 16, FlxColor.PINK);
    }
    
    /**
        Removes object from the stage without destroying it.

        @param name Name under which the object should be added
        @param object The object itself
    **/
    public function remove(name:String):Void {
        if (objects.exists(name)) {
            objects.remove(name);
        }
    }

    /**
        Removes and destroy the object from the stage.

        @param name Name under which the object should be added
        @param object The object itself
    **/    
    public function delete(name:String):Void {
        if (objects.exists(name)) {
            remove(name);
            objects.get(name).destroy();
        }
    }
}
