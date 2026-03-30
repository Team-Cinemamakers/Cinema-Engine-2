package funkin.objects;

import backend.Paths;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import funkin.objects.Strumline;
import funkin.states.PlayState;

class LongNote extends FlxSpriteGroup {
    var pixelLength:Float = 0;
    var note:Note;
    var noteSparrow:FlxAtlasFrames;
    var noteEndSparrow:FlxAtlasFrames;
    var useOneSpritesheet:Null<Bool> = false;
    var useShader:Bool = true;
	public function new(note:Note, x:Float = 0, y:Float = 0)
	{
        this.note = note;

        super(x, y);

        if (useOneSpritesheet != null) useOneSpritesheet = note.strumline.noteskinData.sustains.useOneSpritesheet;
        else useOneSpritesheet = true;

        useShader = note.strumline.noteskinData.useColorShader;

        if (note.strumline.noteskinData.spriteType == "seperate") {
			if (note.strumline.noteskinData.strums.spritesheet == null) trace("SPRITESHEET IS NULL, UH OH");
			else {
				if (Paths.exists("assets/engine/images/shared/"+note.strumline.noteskinData.sustains.spritesheet+".png")) noteSparrow = Paths.sparrow(note.strumline.noteskinData.sustains.spritesheet, 'images/shared', ENGINE);
				else if (Paths.exists("assets/content/images/shared/"+note.strumline.noteskinData.sustains.spritesheet+".png")) noteSparrow = Paths.sparrow(note.strumline.noteskinData.sustains.spritesheet, 'images/shared', CONTENT);
				else trace('SUSTAIN SPRITESHEET NOT FOUND');

                if (!useOneSpritesheet) {
                    if (Paths.exists("assets/engine/images/shared/"+note.strumline.noteskinData.sustains.endSpritesheet+".png")) noteEndSparrow = Paths.sparrow(note.strumline.noteskinData.sustains.endSpritesheet, 'images/shared', ENGINE);
                    else if (Paths.exists("assets/content/images/shared/"+note.strumline.noteskinData.sustains.endSpritesheet+".png")) noteEndSparrow = Paths.sparrow(note.strumline.noteskinData.sustains.endSpritesheet, 'images/shared', CONTENT);
                    else trace('SUSTAIN END SPRITESHEET NOT FOUND');
                } else {
                    noteEndSparrow = noteSparrow;
                }
			}
		} else {
			noteSparrow = note.strumline.noteskinSparrow;
            noteEndSparrow = note.strumline.noteskinSparrow;
            useOneSpritesheet = true;
		}

        this.antialiasing = note.strumline.noteskinData.antialiasing;

        pixelLength = (note.strumnote.y + (note.height/2) + ((note.noteData.time + note.noteData.length - Conductor.TIME)/(((1/FlxG.updateFramerate) * 1000)) * (PlayState.scrollSpeed * (60/FlxG.updateFramerate)))) - note.y;

        var imageAmt:Int = Math.ceil(pixelLength/75);
        if(imageAmt <= 0) imageAmt = 1;

        for(i in 0...imageAmt){
            var lsl:Float = pixelLength - ((i-1) * 75);
            if(lsl != 0){
                var part:FlxSprite = new FlxSprite(0, 0);
                part.frames = noteEndSparrow;

                part.animation.addByPrefix('end', note.strumline.noteskinData.sustains.endAnim.animPrefix+note.strumline.members[note.noteData.value%4].name, note.strumline.noteskinData.sustains.endAnim.fps, note.strumline.noteskinData.sustains.endAnim.loop);
		        part.animation.play("end", true);

                part.scale.set(1, (lsl / 75));
                part.updateHitbox();
                part.x = note.x + (note.width/4);
                part.y = note.y + (i * 75);

                part.offset.add(note.strumline.noteskinData.sustains.offset[0]*-1, note.strumline.noteskinData.sustains.offset[1]*-1);

                if (useShader) part.shader = note.shader;
                add(part);
            } else {
                var part:FlxSprite = new FlxSprite(0, 0);
                part.frames = noteSparrow;

                part.animation.addByPrefix('base', note.strumline.noteskinData.sustains.baseAnim.animPrefix+note.strumline.members[note.noteData.value%4].name, note.strumline.noteskinData.sustains.baseAnim.fps, note.strumline.noteskinData.sustains.baseAnim.loop);
		        part.animation.play("base", true);

                part.x = note.x + (note.width/4);
                part.y = note.y + (i * 75);

                part.offset.add(note.strumline.noteskinData.sustains.offset[0]*-1, note.strumline.noteskinData.sustains.offset[1]*-1);

                if (useShader) part.shader = note.shader;
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
            // trace('destroyed missed note');
            // trace('destroyed self');
            this.note.setCharactersLongNoteState(false);
            PlayState.instance.notesTypedGroup.remove(this.note, true);
            note.destroy();
            this.destroy();
        }
	}
}
