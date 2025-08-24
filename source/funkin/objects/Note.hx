package funkin.objects;

import backend.Paths;
import flixel.graphics.frames.FlxAtlasFrames;
import funkin.objects.Strumline;

typedef NoteData =
{
	var time:Float; // time at which the note is supposed to be pressed
	var type:Int; // note type (0 for normal)
	var value:Int; // value (corresponds to the place in the strumline, so on 4k its from 0-3 and on 7k its from 0-6 and so on)
}

class Note extends FlxSprite {
    
	public var noteData:NoteData;
	public var strumline:Strumline;

	var scaleX:Float;
	var scaleY:Float;

	public var startY:Float = 0;

	public var moving:Bool = false;
	var offsetNote:Float;
	var strumnote:StrumNote;
	var tempNoScroll:Bool = false;

	var justMovedY:Float = 0;
	var justRecalc:Bool = false;

	var framesAdded:Bool = false;

	public var iterator:Int = 0;

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

		this.scale.set(scaleX, scaleY);
		this.frames = frames;

		offsetNote = this.width / 4;
		strumnote = strumline.members[noteData.value];
		if(PlayState.instance != null){
			PlayState.instance.add(this);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function addFrames():Void{
		if(framesAdded) return;
		framesAdded = true;
		
		this.frames = frames;

		animation.addByPrefix('note', 'noteUp', 24);
		animation.play('note', true);
	}

	public function clickedOnRow():Bool
	{
		if (MathFunctions.isInRange(y, strumline.members[noteData.value].y, 100))
		{
			return true;
		}
		else
			return false;
	}
}
