package funkin.objects;

import backend.Paths;
import flixel.graphics.frames.FlxAtlasFrames;
import funkin.objects.Strumline;

typedef NoteData =
{
	var time:Float; // Time at which the note is supposed to be pressed
	var type:Int; // Note type (0 for normal)
	var value:Int; // Value (corresponds to the place in the strumline, so on 4k its from 0-3 and on 7k its from 0-6 and so on)
	var length:Float;
}

class Note extends FlxSprite {
    
	public var noteData:NoteData;
	public var strumline:Strumline;

	var scaleX:Float;
	var scaleY:Float;

	public var startY:Float = 0;

	public var moving:Bool = false;
	var offsetNote:Float;
	public var strumnote:StrumNote;
	var tempNoScroll:Bool = false;

	var justMovedY:Float = 0;
	var justRecalc:Bool = false;

	var framesAdded:Bool = false;

	public var iterator:Int = 0;

	public var longNoteStretch:FlxSprite;

	public var held:Bool = false;

	public function new(angle:Float = 0, strumline:Strumline, noteData:NoteData, x:Float = 0, y:Float = 0, scaleX:Float, scaleY:Float, frames:FlxAtlasFrames, iterator:Int)
	{
		y = FlxG.height + this.height / 2;
		this.startY = y;

        super(x, y);

		centerOrigin();
		centerOffsets();

		this.scaleX = scaleX;
		this.scaleY = scaleY;
		this.updateHitbox();

        this.angle = angle + 180;
		this.noteData = noteData;

		this.iterator = iterator;

        this.strumline = strumline;
		this.frames = frames;

		this.scale.set(scaleX, scaleY);

		offsetNote = this.width / 4;
		strumnote = strumline.members[noteData.value];
		if(PlayState.instance != null){
			PlayState.instance.notesTypedGroup.add(this);
		}
	}

	var playedHitsound:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		x = strumnote.x + (this.width/4);
		if(noteData.time - ((startY - (strumnote.y + (this.height/2)))/(PlayState.scrollSpeed * (1/FlxG.updateFramerate))) * ((1/FlxG.updateFramerate) * 1000) <= Conductor.TIME){
			if(!moving) moving = true;
			y = strumnote.y + (this.height/2) + ((noteData.time - Conductor.TIME)/(((1/FlxG.updateFramerate) * 1000)) * (PlayState.scrollSpeed * (60/FlxG.updateFramerate)));
		}
		if(moving){
			if(noteData.length > 0 && longNoteStretch == null){
				longNoteStretch = new FlxSprite().loadGraphic(Paths.image('NOTE_hold_assets', "images/shared", PathSource.ENGINE));
				longNoteStretch.x = this.x + (this.width/2) - (longNoteStretch.width/2);
				PlayState.instance.add(longNoteStretch);
			} else if (longNoteStretch != null){
				longNoteStretch.updateHitbox();
				var endPos:Float = strumnote.y + (this.height/2) + (((noteData.time + noteData.length) - Conductor.TIME)/(((1/FlxG.updateFramerate) * 1000)) * (PlayState.scrollSpeed * (60/FlxG.updateFramerate)));
				longNoteStretch.scale.set(1, endPos - (this.y));
				longNoteStretch.updateHitbox();
				longNoteStretch.x = strumnote.x - (longNoteStretch.width/2);
				longNoteStretch.y = this.y;
			}
		}

		if(y <= 0 - this.height){
			if(held && longNoteStretch != null){
				if(longNoteStretch.y <= 0 - longNoteStretch.height){
					trace("try destroy longNote");
					this.longNoteStretch.destroy();
					PlayState.instance.notesTypedGroup.remove(this, true);
					this.destroy();
				}
			} else {
				if(longNoteStretch != null){
					trace("try destroy longNote");
					this.longNoteStretch.destroy();
				}
				PlayState.instance.notesTypedGroup.remove(this, true);
				this.destroy();
				// #if desktop
				// Gc.run(true);
				// #end
			}
		}

		if(y <= strumnote.y + (this.height/2)){
			if(!playedHitsound && moving){
				playedHitsound = true;
				if(!this.strumnote.playable){
					if(longNoteStretch != null){
						this.longNoteStretch.destroy();
					}
					this.strumnote.pressedOnNote = true;
					PlayState.instance.activateEnemyNote(this.strumnote, this.noteData.value);
					PlayState.instance.notesTypedGroup.remove(this, true);
					this.destroy();
					// #if desktop
					// Gc.run(true);
					// #end
				}
				//PlayState.hitsound.play(true);
			}
		}
	}

	public function clickedOnRow():Bool
	{
		if (MathUtil.isInRange(y, strumnote.y, 100))
		{
			return true;
		}
		else
			return false;
	}
}
