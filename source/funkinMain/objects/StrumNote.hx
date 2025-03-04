package funkinMain.objects;

import backend.CoolInput;
import backend.Paths;

class StrumNote extends FlxSprite {

    public var input:String;
    public var strumOwner:String;

    public function new(input:String = "noteLeft", angle:Float = 0, strumOwner:String = "bf", x:Float = 0, y:Float = 0) {
        super(x, y);
        this.input = input;
        this.angle = angle;

        frames = Paths.sparrow('images/shared/noteStrumline');

        animation.addByPrefix("static", "staticUp", 24, false);
        animation.addByPrefix("press", "pressUp", 24, false);
        animation.addByPrefix("confirm", "confirmUp", 24, false);

        animation.play("static", true);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (CoolInput.pressed(input)) {
            animation.play("press", true);
        } else {
            animation.play("static", true);
        }
    }
}