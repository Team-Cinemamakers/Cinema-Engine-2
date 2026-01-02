package funkin.objects;

import flixel.group.FlxSpriteGroup;

class Alphabet extends FlxSpriteGroup{
    var letterScaleValue:Float = 1;
    public function new(x:Float, y:Float, text:String = "test", desiredHeight:Float = 30){
        super(x, y);
        for(i in 0...text.length){
            var letter:FlxSprite = new FlxSprite();
            var char:String = text.charAt(i);
            if(char == ' '){
                char = "0";
                letter.alpha = 0;
            }
            letter.frames = Paths.sparrow("alphabet", 'images/shared', ENGINE, letter, true, true);
            letter.animation.addByPrefix(text.charAt(i), text.charAt(i).toUpperCase() + " bold", 24, true);
            letter.animation.play(text.charAt(i));
            if(i == 0) letterScaleValue = desiredHeight/letter.height;
            letter.scale.set(letterScaleValue, letterScaleValue);
            letter.updateHitbox();
            letter.x = this.x;
            if(i != 0) letter.x = this.members[i-1].x + this.members[i-1].width;
            letter.updateHitbox();
            letter.y = this.y;
            this.add(letter);
        }
    }
}