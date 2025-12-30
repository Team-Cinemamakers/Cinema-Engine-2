package funkin.objects;

import backend.Paths;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import funkin.objects.Strumline;
import funkin.states.PlayState;

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
            var lsl:Float = pixelLength - ((i-1) * 75);
            if(lsl != 0){
                var part:FlxSprite = new FlxSprite(0, 0);
                part.frames = Paths.sparrow("NOTE_hold_default_end", 'images/shared', ENGINE);
                part.scale.set(1, (lsl / 75));
                part.updateHitbox();
                part.x = note.x + (note.width/4);
                part.y = note.y + (i * 75);
                part.shader = note.shader;
                add(part);
            } else {
                var part:FlxSprite = new FlxSprite(0, 0);
                part.frames = Paths.sparrow("NOTE_hold_default", 'images/shared', ENGINE);
                part.x = note.x + (note.width/4);
                part.y = note.y + (i * 75);
                part.shader = note.shader;
                add(part);
            }
        }

        //this.clipRect = note.strumnote.clip;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

        for(i in 0...this.length){
            this.members[i].x = note.x + (note.width/4);
            this.members[i].y = note.y + (i * 75) + 30;
            if(this.members[i].y - 75 <= note.strumnote.y){
                this.members[i].alpha = 0;
            } else {
                this.members[i].alpha = 1;
            }
        }

        if(this.members[0].y + pixelLength <= 0){
            trace('destroyed missed note');
            trace('destroyed self');
            PlayState.instance.notesTypedGroup.remove(this.note, true);
            note.destroy();
            this.destroy();
        }
	}
}
