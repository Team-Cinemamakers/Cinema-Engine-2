package funkin.objects;

import backend.shaders.NoteShader;
import flixel.graphics.frames.FlxAtlasFrames;
import funkin.objects.StrumNote;

class NoteSplash extends FlxSprite {
    
    public var strum:StrumNote;

    public function new(strum:StrumNote, x:Float = 0, y:Float = 0) {
        super(x, y);

        frames = Paths.sparrow('noteSplash', 'images/shared', ENGINE, this);
        //frames = flxanimate.frames.FlxAnimateFrames.fromSparrow(Paths.xml('noteSplash', 'images/shared', ENGINE), Paths.bitmap('noteSplash', 'images/shared', ENGINE));

        animation.addByPrefix("splash", "note splash red 1", 24, false);
        
        animation.onFinish.add(function(animName) {
            this.destroy();
        });

        this.shader = strum.noteShader;
    }

    public function splash() {
        this.animation.play("splash", true);
    }

}