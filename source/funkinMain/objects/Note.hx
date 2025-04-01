package funkinMain.objects;

import backend.Paths;
import funkinMain.objects.Strumline;

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

	public function new(angle:Float = 0, strumline:Strumline, noteData:NoteData, x:Float = 0, y:Float = 0, scaleX:Float, scaleY:Float)
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

        this.strumline = strumline;

		this.scale.set(scaleX, scaleY);
		frames = Paths.sparrow('images/shared/notes');

		animation.addByPrefix('note', 'noteUp', 24);
		animation.play('note', true);

		offsetNote = this.width / 4;
		strumnote = strumline.members[noteData.value];
		// y += strumline.members[noteData].y;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (y <= 0 - height)
			{
				this.destroy();
			}

		var scrollAmount:Float = (PlayState.song.metadata.scrollSpeed * elapsed) * 1000;

		x = strumnote.x + offsetNote;

		if (noteData.time
			- (((FlxG.height +
				this.height / 2) - strumline.members[noteData.value].y - strumline.members[noteData.value].height/2) / ((PlayState.song.metadata.scrollSpeed) * 1000) * 1000) <= Conductor.TIME)
		{
			if (!moving){
				moving = true;
			}
			
			y -= scrollAmount;

			if (y <= 0 - height)
				{
					moving = false;
					this.destroy();
				}
		}
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

	public function recalculateNoteScreenPosition(){
		var noteMoveTime:Float = noteData.time
		- (((FlxG.height +
			this.height / 2) - strumline.members[noteData.value].y - strumline.members[noteData.value].height/2) / ((PlayState.song.metadata.scrollSpeed) * 1000) * 1000);

			if(noteMoveTime > Conductor.TIME) return;

			if(Conductor.TIME >= noteData.time){
				this.destroy();
			}

			if(!moving) moving = true;

			var newy:Float = ((Conductor.TIME - noteData.time)/-1000) * (PlayState.song.metadata.scrollSpeed * 1000) + (strumline.members[noteData.value].y - strumline.members[noteData.value].height/2);
			this.y = newy;

			if(newy <= 0 - height){
				moving = false;
				this.destroy();
				trace('destroyed');
			} else if (newy >= FlxG.height + this.height/2){
				y = FlxG.height + this.height/2;
			}
		}
}
