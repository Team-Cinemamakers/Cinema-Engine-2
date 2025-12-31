package funkin.objects;

import backend.Paths;
import backend.shaders.NoteShader;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets;
import funkin.objects.LongNote;
import funkin.objects.Strumline;
import haxe.io.Scheme;

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

	public var held:Bool = false;

	public var longNote:LongNote;

	public var input:String = "";

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

        this.angle = angle;
		this.noteData = noteData;

		this.iterator = iterator;

        this.strumline = strumline;
		this.frames = frames;

		this.scale.set(scaleX, scaleY);

		lastSS = PlayState.scrollSpeed;

		offsetNote = this.width / 4;
		strumnote = strumline.members[noteData.value];
		if(PlayState.instance != null){
			PlayState.instance.notesTypedGroup.add(this);
		}
		this.shader = strumnote.noteShader;
		x = strumnote.x + (this.width/4);
	}

	var playedHitsound:Bool = false;
	var lastSS:Float = -1;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if(moving){
			if(longNote == null && noteData.length > 0){
				longNote = new LongNote(this);
				longNote.cameras = this.cameras;
				longNote.zIndex = this.zIndex-1;
				SortUtil.reorder();
				PlayState.instance.add(longNote);
			}
		}

		if(y <= 0 - this.height && longNote == null){
				PlayState.instance.notesTypedGroup.remove(this, true);
				PlayState.instance.noteMiss(this, this.strumnote.input);
				this.destroy();
				// #if desktop
				// Gc.run(true);
				// #end
			}

		if(y <= strumnote.y + (this.height/2)){
			if(!playedHitsound && moving){
				playedHitsound = true;
				if(!this.strumnote.playable){
					this.strumnote.pressedOnNote = true;
					PlayState.instance.activateEnemyNote(this.strumnote, this.noteData.value);
					if (this.longNote != null){
						this.alpha = 0;
					} else {
						PlayState.instance.notesTypedGroup.remove(this, true);
						this.destroy();
					}
					// #if desktop
					// Gc.run(true);
					// #end
				}
				//PlayState.hitsound.play(true);
			}
		}

		if(this.longNote != null && !CoolInput.held(this.strumnote.input) && this.held){
			this.held = false;
			PlayState.instance.notesTypedGroup.remove(this, true);
			PlayState.instance.noteMiss(this, this.strumnote.input);
			trace('missed long note');
            this.longNote.destroy();
            this.destroy();
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

	public override function draw()
	{
		if(moving){
			super.draw();
		}
	}

	public override function destroy(){
		PlayState.instance.noteMap.get(strumline).remove(this);
		super.destroy();
	}
}
