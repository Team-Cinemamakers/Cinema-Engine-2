package funkin.objects;

import backend.shaders.NoteShader;
import flixel.graphics.frames.FlxAtlasFrames;
import funkin.objects.StrumNote;

class NoteSplash extends FlxSprite {
    
    public var strum:StrumNote;
    public var noteSparrow:FlxAtlasFrames;
    public var useShader:Bool = true;

    public function new(strum:StrumNote, x:Float = 0, y:Float = 0) {
        super(x, y);

        //frames = Paths.sparrow('noteSplash', 'images/shared', ENGINE, this);
        //frames = flxanimate.frames.FlxAnimateFrames.fromSparrow(Paths.xml('noteSplash', 'images/shared', ENGINE), Paths.bitmap('noteSplash', 'images/shared', ENGINE));

        this.useShader = strum.strumline.noteskinData.useColorShader;

		if (strum.strumline.noteskinData.strums.spritesheet == null) trace("SPRITESHEET IS NULL, UH OH");
		else {
			if (Paths.exists("assets/engine/images/shared/"+strum.strumline.noteskinData.splashes.spritesheet+".png")) noteSparrow = Paths.sparrow(strum.strumline.noteskinData.splashes.spritesheet, 'images/shared', ENGINE, this);
			else if (Paths.exists("assets/content/images/shared/"+strum.strumline.noteskinData.splashes.spritesheet+".png")) noteSparrow = Paths.sparrow(strum.strumline.noteskinData.splashes.spritesheet, 'images/shared', CONTENT, this);
			else trace('SPLASHES SPRITESHEET NOT FOUND');
		}
		frames = noteSparrow;

		this.antialiasing = strum.strumline.noteskinData.antialiasing;

        animation.addByPrefix("splash", strum.strumline.noteskinData.splashes.splashAnim.animPrefix, strum.strumline.noteskinData.splashes.splashAnim.fps, strum.strumline.noteskinData.splashes.splashAnim.loop);
        // animation.play("splash", true);
        
        animation.onFinish.add(function(animName) {
            this.destroy();
        });

        if (useShader) this.shader = strum.noteShader;
    }

    public function splash() {
        this.animation.play("splash", true);
    }

}