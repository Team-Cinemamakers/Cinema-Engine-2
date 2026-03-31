package funkin.objects;

import backend.shaders.NoteShader;
import flixel.graphics.frames.FlxAtlasFrames;
import funkin.objects.StrumNote;

class LongNoteCover extends FlxSprite {
    
    public var strum:StrumNote;
    public var noteSparrow:FlxAtlasFrames;
    public var useShader:Bool = true;
    public var doEndAnim:Bool = true;

    public function new(strum:StrumNote, x:Float = 0, y:Float = 0, doEndAnim:Bool = true, group:FlxTypedGroup<LongNoteCover>) {
        super(x, y);

        //frames = Paths.sparrow('noteSplash', 'images/shared', ENGINE, this);
        //frames = flxanimate.frames.FlxAnimateFrames.fromSparrow(Paths.xml('noteSplash', 'images/shared', ENGINE), Paths.bitmap('noteSplash', 'images/shared', ENGINE));

        this.useShader = strum.strumline.noteskinData.useColorShader;
        this.doEndAnim = doEndAnim;
        this.strum = strum;

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
        //animation.play("start", true);
        
        animation.onFinish.add(function(animName) {
            trace(animName+" just finished");
            if (animName == "start") animation.play("loop");
            if (animName == "end") {
                group.remove(this, true);
                this.destroy();
            }
        });

        if (useShader) this.shader = strum.noteShader;
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (animation.curAnim.name == "loop") offset.set(strum.strumline.noteskinData.sustainCovers.loopOffset[0], strum.strumline.noteskinData.sustainCovers.loopOffset[1]);
        else if (animation.curAnim.name == "end") offset.set(strum.strumline.noteskinData.sustainCovers.endOffset[0], strum.strumline.noteskinData.sustainCovers.endOffset[1]);
        else offset.set();
    }

    public function start() {
        this.animation.play("start", true);
    }
    
    public function end() {
        if (this == null) return; // idk how this would be the case, but whatever
        if (doEndAnim) {
            this.animation.play("end", true);
            trace("doin end anim");
        }
        else {
            trace('no end anim');
            this.destroy();
        }
    }

}