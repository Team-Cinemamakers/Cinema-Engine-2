package funkinMain.objects;

import backend.CoolInput;
import backend.Paths;

class StrumNote extends FlxSprite {

    public var input:String;
	public var character:String;
	public var playable:Bool;
	public var animOffsets:Map<String, Array<Float>> = new Map();

	public function new(input:String = "noteLeft", angle:Float = 0, character:String = "bf", playable:Bool = false, x:Float = 0, y:Float = 0)
	{
        super(x, y);
        this.input = input;
        this.angle = angle;
		this.character = character;
		this.playable = playable;

        frames = Paths.sparrow('images/shared/noteStrumline');

        animation.addByPrefix("static", "staticUp", 24, false);
        animation.addByPrefix("press", "pressUp", 24, false);
		animation.addByPrefix("confirm", "confirmUp", 24, false);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

		if (CoolInput.held(input) && playable)
		{
			if (animation.curAnim.name != 'press')
				playAnim('press');
        } else {
			playAnim('static');
		}
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