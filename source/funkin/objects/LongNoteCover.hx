package funkin.objects;

import backend.shaders.NoteShader;
import flixel.graphics.frames.FlxAtlasFrames;
import funkin.objects.StrumNote;

class LongNoteCover extends FlxSprite {
    
    public var strum:StrumNote;
    public var noteSparrow:FlxAtlasFrames;
    public var useShader:Bool = true;
    public var doEndAnim:Bool = true;

    public function new(strum:StrumNote, x:Float = 0, y:Float = 0, doEndAnim:Bool = true) {
        super(x, y);

        //frames = Paths.sparrow('noteSplash', 'images/shared', ENGINE, this);
        //frames = flxanimate.frames.FlxAnimateFrames.fromSparrow(Paths.xml('noteSplash', 'images/shared', ENGINE), Paths.bitmap('noteSplash', 'images/shared', ENGINE));

        this.useShader = strum.strumline.noteskinData.useColorShader;
        this.doEndAnim = doEndAnim;

		if (strum.strumline.noteskinData.strums.spritesheet == null) trace("SPRITESHEET IS NULL, UH OH");
		else {
			if (Paths.exists("assets/engine/images/shared/"+strum.strumline.noteskinData.sustainCovers.spritesheet+".png")) noteSparrow = Paths.sparrow(strum.strumline.noteskinData.sustainCovers.spritesheet, 'images/shared', ENGINE, this);
			else if (Paths.exists("assets/content/images/shared/"+strum.strumline.noteskinData.sustainCovers.spritesheet+".png")) noteSparrow = Paths.sparrow(strum.strumline.noteskinData.sustainCovers.spritesheet, 'images/shared', CONTENT, this);
			else trace('COVERS SPRITESHEET NOT FOUND');
		}
		frames = noteSparrow;

		this.antialiasing = strum.strumline.noteskinData.antialiasing;

        animation.addByPrefix("start", strum.strumline.noteskinData.sustainCovers.startAnim.animPrefix+strum.name, strum.strumline.noteskinData.sustainCovers.startAnim.fps, strum.strumline.noteskinData.sustainCovers.startAnim.loop);
        animation.addByPrefix("loop", strum.strumline.noteskinData.sustainCovers.loopAnim.animPrefix+strum.name, strum.strumline.noteskinData.sustainCovers.loopAnim.fps, strum.strumline.noteskinData.sustainCovers.loopAnim.loop);
        animation.addByPrefix("end", strum.strumline.noteskinData.sustainCovers.endAnim.animPrefix+strum.name, strum.strumline.noteskinData.sustainCovers.endAnim.fps, strum.strumline.noteskinData.sustainCovers.endAnim.loop);
        // animation.play("splash", true);
        
        animation.onFinish.add(function(animName) {
            if (animName == "start") animation.play("loop");
            if (animName == "end") this.destroy();
        });

        if (useShader) this.shader = strum.noteShader;
    }

    public function start() {
        this.animation.play("start", true);
    }
    
    public function end() {
        if (doEndAnim) this.animation.play("end", true);
        else this.destroy();
    }

}