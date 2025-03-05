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
    
    public var noteData:Int;
    public var noteType:Int;
    public var strumline:Strumline;
	public var time:Float;

	public var moving:Bool;

	var scaleX:Float;
	var scaleY:Float;

	public function new(angle:Float = 0, strumline:Strumline, noteData:Int = 0, noteType = 0, x:Float = 0, y:Float = 0, scaleX:Float, scaleY:Float, time:Float)
	{
        super(x, y);

        this.angle = angle;
        this.noteData = noteData;
		this.noteType = noteType;
		this.time = time;

        this.strumline = strumline;

		this.scaleX = scaleX;
		this.scaleY = scaleY;

        x = strumline.members[noteData].x;

		// y += strumline.members[noteData].y;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		x = strumline.members[noteData].x;
	}

	// we call this to load the note so theres not 1 zillion notes in memory when loading the chart
	public function loadNoteGraphic(notesGroup:FlxTypedGroup<Note>)
	{
		this.scale.set(scaleX, scaleY);
		frames = Paths.sparrow('images/shared/notes');

		animation.addByPrefix('note', 'noteUp', 24);
		animation.play('note', true);

		notesGroup.add(this);
	}
}