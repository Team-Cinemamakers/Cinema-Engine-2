package funkin.objects;

import backend.CoolInput;
import backend.shaders.NoteShader;
import backend.utils.MathUtil;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxRect;
import funkin.objects.Strumline;
import funkin.states.PlayState;

typedef StrumNoteData =
{
	var name:String; // strumnote name for noteskin bs
	var input:String; // input, or animation
	var angle:Float; // angle at which the note should be rotated, will be useful in the future when we switch to a single color note sprite and just recolor it
	var color:Array<String>;
}

class StrumNote extends FlxSprite {

	public var name:String;
    public var input:String;
	public var characterNames:Array<String>;
	public var characters:Array<Character>;
	public var playable:Bool;
	public var animOffsets:Map<String, Array<Float>> = new Map();
	public var clip:FlxRect;
	public var value:Int = 0;
	public var strumline:Strumline;

	public var scrollDirection:String = "auto";

	public var pressedOnNote:Bool = false;

	private var noteSparrow:FlxAtlasFrames;

	public var useShader:Bool = true;
	public var noteShader:NoteShader;

	public final defaultColors:Array<Array<String>> = [["0xBF4C99", "0xFFFFFF", "0x3F205C"], ["0x01FFFF", "0xFFFFFF", "0x1840BA"], ["0x12FA04", "0xFFFFFF", "0x034A42"], ["0xF83845", "0xFFFFFF", "0x6F0E39"]];

	public function new(name:String = "Up", input:String = "noteLeft", angle:Float = 0, characterNames:Array<String>, playable:Bool = false, x:Float = 0, y:Float = 0, characters:Array<Character>, color:Array<String>, value:Int = 0, strumline:Strumline)
	{
        super(x, y);
		this.name = name;
        this.input = input;
        this.angle = angle;
		if(characterNames == null) characterNames = ["bf"];
		this.characterNames = characterNames;
		this.playable = playable;
		this.characters = characters;
		this.strumline = strumline;

		this.useShader = strumline.noteskinData.useColorShader;

		if (strumline.noteskinData.spriteType == "seperate") {
			// trace("FINDING PATH: " + Paths.file(strumline.noteskinData.strums.spritesheet, 'images/shared', ENGINE));
			if (strumline.noteskinData.strums.spritesheet == null) trace("SPRITESHEET IS NULL, UH OH");
			else {
				if (Paths.exists("assets/engine/images/shared/"+strumline.noteskinData.strums.spritesheet+".png")) noteSparrow = Paths.sparrow(strumline.noteskinData.strums.spritesheet, 'images/shared', ENGINE);
				else if (Paths.exists("assets/content/images/shared/"+strumline.noteskinData.strums.spritesheet+".png")) noteSparrow = Paths.sparrow(strumline.noteskinData.strums.spritesheet, 'images/shared', CONTENT);
				else trace('STRUM SPRITESHEET NOT FOUND');
			}
			frames = noteSparrow;
		} else {
			frames = strumline.noteskinSparrow;
		}

		this.antialiasing = strumline.noteskinData.antialiasing;

        animation.addByPrefix("static", strumline.noteskinData.strums.staticAnim.animPrefix+name, strumline.noteskinData.strums.staticAnim.fps, strumline.noteskinData.strums.staticAnim.loop);
        animation.addByPrefix("press", strumline.noteskinData.strums.pressAnim.animPrefix+name, strumline.noteskinData.strums.pressAnim.fps, strumline.noteskinData.strums.pressAnim.loop);
		animation.addByPrefix("confirm", strumline.noteskinData.strums.confirmAnim.animPrefix+name, strumline.noteskinData.strums.confirmAnim.fps, strumline.noteskinData.strums.confirmAnim.loop);

		centerOffsets();
		centerOrigin();

		clip = new FlxRect(0, this.y, 1280, 720);

		this.value = value;

		if(color == null){
			if(defaultColors[value] == null){
				color = defaultColors[0];
			} else {
				color = defaultColors[value];
			}
		}
		
		// trace(Std.parseInt(color[0]));

		if (useShader) {
			noteShader = new NoteShader();
			noteShader.redColor.value = MathUtil.hexToRGB(color[0]);
			noteShader.greenColor.value = MathUtil.hexToRGB(color[1]);
			noteShader.blueColor.value = MathUtil.hexToRGB(color[2]);
		}
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

		if (CoolInput.held(input) && playable)
		{
			if (!pressedOnNote) {
				if (animation.curAnim.name != 'press') {
					if (useShader) this.shader = noteShader;
					playAnim('press');
				}
			} else {
				if (animation.curAnim.name != 'confirm') {
					if (useShader) this.shader = noteShader;
					playAnim('confirm');
				}
			}
			
        } else if (!playable) {
			if(!pressedOnNote && !characters[0].playingLongNote){
				if (useShader) this.shader = null;
				playAnim('static');
			} else {
				if (animation.curAnim.name != 'confirm' && pressedOnNote) {
					if (useShader) this.shader = noteShader;
					playAnim('confirm');
				}
			}
		} else {
			if (useShader) this.shader = null;
			playAnim('static');
			pressedOnNote = false;
		}
		clip.y = this.y + (this.height / 2);
	}

	public function playAnim(anim:String, ?force:Bool = false)
	{
		animation.play(anim, force);
		centerOffsets();
		centerOrigin();

		if (animOffsets.exists(anim))
		{
			offset.set(offset.x + animOffsets.get(anim)[0], offset.y + animOffsets.get(anim)[1]);
		}

		if (animation.curAnim == null || animation.curAnim.name == 'static') {}
		else
		{
			if (animation.curAnim.name == 'confirm')
			{
				centerOrigin();
			}
		}
	}
	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}