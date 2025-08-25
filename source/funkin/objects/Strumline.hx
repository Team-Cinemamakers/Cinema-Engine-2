package funkin.objects;

import funkin.objects.Note.NoteData;
import funkin.objects.StrumNote;

typedef StrumlineData =
{
	var characters:Array<String>; // strumline owner (initial at least)
	var notes:Array<NoteData>; // notes belonging to this strumline
}

typedef StrumlineInfo =
{
	var characters:Array<String>; // strumline owner
	var strumNotes:Array<StrumNoteData>; // strumnote data (defines all the strum notes)
	var position:Array<Float>; // position of the strumline
	var scale:Array<Float>; // scale of the strumline
	var kerning:Float; // distance between notes
	var playable:Bool; // whether this strumline should react to player input basically
	var viewable:Bool; // whether this strumline is even visible
}

class Strumline extends FlxTypedGroup<StrumNote>
{
	public var strumNotes:Array<StrumNoteData>;
	public var x:Float;
	public var y:Float;

	public var scale:Array<Float> = [1, 1];

	public var kerning:Float; // distance between notes
	public var characterNames:Array<String>;
	public var characters:Array<Character>;
	public var playable:Bool;
	public var viewable:Bool;

	public var allowUpdateStrums:Bool = true;

	public function new(strumNotes:Array<StrumNoteData>, characters:Array<String>, playable:Bool = false, kerning:Float = 200, x:Float = 0, y:Float = 0, v:Int = 0)
	{
		super();

		this.strumNotes = strumNotes;

		this.x = x;
		this.y = y;
		this.characterNames = characters;
		this.playable = playable;
		this.kerning = kerning;

		if(characters == null){
			characters = ["bf"];
		}

		for(i in 0...this.characterNames.length){
			var char:Character = new Character(this.characterNames[i]);
			char.x = PlayState.instance.getCharacterPositionFromStage(characterNames[i]).x;
			char.y = PlayState.instance.getCharacterPositionFromStage(characterNames[i]).y;
			PlayState.instance.characters.set(characterNames[i], char);
			this.characters.push(char);
		}

		for (i in 0...strumNotes.length)
		{
			var strumNote:StrumNote = new StrumNote(strumNotes[i].input, strumNotes[i].angle, characterNames, playable, x + (i * kerning), y, this.characters);
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

			members[i].characterNames = characterNames;
			members[i].characters = characters;
			members[i].playable = playable;
		}
	}
}
