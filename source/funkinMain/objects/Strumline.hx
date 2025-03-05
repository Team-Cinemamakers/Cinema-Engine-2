package funkinMain.objects;

import funkinMain.objects.Note.NoteData;
import funkinMain.objects.StrumNote;

typedef StrumlineData =
{
	var character:String; // strumline owner (initial at least)
	var notes:Array<NoteData>; // notes belonging to this strumline
}

typedef StrumlineInfo =
{
	var character:String; // strumline owner
	var strumNotes:Array<StrumNoteData>; // strumnote data (defines all the strum notes)
	var position:Array<Float>; // position of the strumline
	var scale:Array<Float>; // scale of the strumline
	var kerning:Float; // distance between notes
	var playable:Bool; // whether this strumline should react to player input basically
}

class Strumline extends FlxTypedGroup<StrumNote>
{
	public var strumNotes:Array<StrumNoteData>;
	public var x:Float;
	public var y:Float;

	public var scale:Array<Float> = [1, 1];

	public var kerning:Float; // distance between notes
	public var character:String;
	public var playable:Bool;

	public var allowUpdateStrums:Bool = false;

	public function new(strumNotes:Array<StrumNoteData>, character:String = "bf", playable:Bool = false, kerning:Float = 200, x:Float = 0, y:Float = 0)
	{
		super();

		this.strumNotes = strumNotes;

		this.x = x;
		this.y = y;
		this.character = character;
		this.playable = playable;
		this.kerning = kerning;

		for (i in 0...strumNotes.length)
		{
			var strumNote:StrumNote = new StrumNote(strumNotes[i].input, strumNotes[i].angle, character, playable, x + (i * kerning), y);
			add(strumNote);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (allowUpdateStrums)
		{
			updateStrums();
		}
	}

	public function updateStrums()
	{
		for (i in 0...members.length)
		{
			members[i].scale.x = scale[0];
			members[i].scale.y = scale[1];

			members[i].x = x + (i * kerning);
			members[i].y = y;

			members[i].character = character;
			members[i].playable = playable;
		}
	}
}
