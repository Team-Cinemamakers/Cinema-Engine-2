package funkin.objects;

import backend.Paths;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import funkin.objects.Strumline;

class LongNote extends FlxSpriteGroup {
    var pixelLength:Float = 0;
    var note:Note;
	public function new(note:Note, x:Float = 0, y:Float = 0)
	{
        this.note = note;

        super(x, y);

        pixelLength = (note.strumnote.y + (note.height/2) + ((note.noteData.time + note.noteData.length - Conductor.TIME)/(((1/FlxG.updateFramerate) * 1000)) * (PlayState.scrollSpeed * (60/FlxG.updateFramerate)))) - note.y;

        var imageAmt:Int = Math.ceil(pixelLength/75);
        if(imageAmt <= 0) imageAmt = 1;

        for(i in 0...imageAmt){
            var part:FlxSprite = new FlxSprite(0, 0);
            part.frames = Paths.sparrow("NOTE_hold_default", 'images/shared', ENGINE);
            part.x = note.x + (note.width/4);
            part.y = note.y + (i * 75);
            add(part);
        }
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

        for(i in 0...this.length){
            this.members[i].x = note.x + (note.width/4);
            this.members[i].y = note.y + (i * 75);
        }
	}
}
