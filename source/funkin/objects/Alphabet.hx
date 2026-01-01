package funkin.objects;

import flixel.group.FlxSpriteGroup;

class Alphabet extends FlxSpriteGroup{
    public function new(x:Float, y:Float, text:String = "test"){
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
            letter.x = this.x;
            if(this.members[i - 1] != null) letter.x = this.members[i - 1].x + this.members[i - 1].width + 5;
            letter.y = this.y;
            this.add(letter);
        }
    }
}