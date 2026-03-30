package funkin.data;

/* THIS SYSTEM IS SO FUCKING ASS I AM SO FUCKING SORRY -AngieDev */

typedef NoteskinData = {
    var name:String;
    var antialiasing:Bool;
    var spriteType:String; // seperate (Uses seperate spritesheets for everything), single (Uses one spritesheet for everything [Like in every other engine])
    var spritesheet:Null<String>; // For single
    var useColorShader:Bool;
    var notes:NoteskinNotes;
    var strums:NoteskinStrums;
    var sustains:NoteskinSustains;
    var splashesEnabled:Bool;
    var splashes:Null<NoteskinSplashes>;
    var sustainCoversEnabled:Bool;
    var sustainCovers:Null<NoteskinSustainCovers>;
}

typedef NoteskinNotes = {
    var spritesheet:Null<String>;
    var noteAnim:NoteskinAnimation;
    var offset:Array<Float>;
}

typedef NoteskinStrums = {
    var spritesheet:Null<String>;
    var confirmAnim:NoteskinAnimation;
    var pressAnim:NoteskinAnimation;
    var staticAnim:NoteskinAnimation;
    var offset:Array<Float>;
}

typedef NoteskinSustains = {
    var spritesheet:Null<String>;
    var endSpritesheet:Null<String>;
    var useOneSpritesheet:Null<Bool>; // rather than having 2 spritesheets for the base and end parts of the sustain, use one spritesheet.
    var baseAnim:NoteskinAnimation;
    var endAnim:NoteskinAnimation;
    var offset:Array<Float>;
}

typedef NoteskinSplashes = {
    var spritesheet:String;
    var splashAnim:NoteskinAnimation;
    var offset:Array<Float>;
}

typedef NoteskinSustainCovers = {
    var spritesheet:String;
    var startAnim:NoteskinAnimation;
    var loopAnim:NoteskinAnimation;
    var endAnim:NoteskinAnimation;
    var offset:Array<Float>;
}

typedef NoteskinAnimation = {
    var animPrefix:String;
    var fps:Int;
    var loop:Bool;
}

class Noteskin {
    public static function loadNoteskin(noteskin:String):NoteskinData
	{
        var rawJson = JsonUtil.loadJson(Paths.json(noteskin, "noteskins", CONTENT));
		var casted:NoteskinData = cast(Json.parse(rawJson));
		return casted;
    }
}