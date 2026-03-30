package funkin.objects;

import flixel.graphics.frames.FlxAtlasFrames;
import funkin.data.Noteskin.NoteskinData;
import funkin.data.Noteskin;
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
	var noteskin:String; // the noteskin json this strumline uses
}

class Strumline extends FlxTypedGroup<StrumNote>
{
	public var strumNotes:Array<StrumNoteData>;
	public var x:Float;
	public var y:Float;

	public var scale:Array<Float> = [1, 1];

	public var kerning:Float; // distance between notes
	public var characterNames:Array<String> = [];
	public var characters:Array<Character> = [];
	public var playable:Bool;
	public var viewable:Bool;

	public var noteskin:String;
	public var noteskinData:NoteskinData;

	public var noteskinSparrow:FlxAtlasFrames;

	public var allowUpdateStrums:Bool = true;

	public function new(strumNotes:Array<StrumNoteData>, characters:Array<String>, playable:Bool = false, kerning:Float = 200, noteskin:String, x:Float = 0, y:Float = 0, v:Int = 0)
	{
		super();

		this.strumNotes = strumNotes;

		this.x = x;
		this.y = y;
		this.characterNames = characters;
		this.playable = playable;
		this.kerning = kerning;
		this.noteskin = noteskin;

		this.noteskinData = Noteskin.loadNoteskin(noteskin);

		if (noteskinData.spriteType == "single") {
			if (Paths.exists("assets/engine/images/shared/"+noteskinData.spritesheet+".png")) noteskinSparrow = Paths.sparrow(noteskinData.spritesheet, 'images/shared', ENGINE);
			else if (Paths.exists("assets/content/images/shared/"+noteskinData.spritesheet+".png")) noteskinSparrow = Paths.sparrow(noteskinData.spritesheet, 'images/shared', CONTENT);
			else trace("NOTESKIN SPRITESHEET NOT FOUND UH OH");
		}

		if(characters == null){
			characters = ["bf"];
		}

		for(character in this.characterNames)
		{
			var char = PlayState.instance.characters.get(character);
			this.characters.push(char);
		}

		for (i in 0...strumNotes.length)
		{
			var strumNote:StrumNote = new StrumNote(strumNotes[i].name, strumNotes[i].input, strumNotes[i].angle, characterNames, playable, x + (i * kerning), y, this.characters, strumNotes[i].color, i, this);
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

			members[i].x = x + (i * kerning) + noteskinData.strums.offset[0];
			members[i].y = y + noteskinData.strums.offset[1];

			members[i].characterNames = characterNames;
			members[i].characters = characters;
			members[i].playable = playable;
		}
	}
}
