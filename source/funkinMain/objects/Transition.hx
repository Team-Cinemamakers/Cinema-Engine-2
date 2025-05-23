package funkinMain.objects;

class Transition extends FlxSprite {

    public function new(visible:Bool = true, x:Float = 0, y:Float = 0, style:String = 'basic'){
        super(x, y);

        this.loadGraphic(Paths.image("images/shared/transitions/" + style));
        this.screenCenter(X);
        this.y = 0;
        this.visible = visible;

    }

    public function play(direction:Int = 1, speed:Float = 0.5){
        if(direction == 1){
            y = 0;
            visible = true;
            FlxTween.tween(this, {y: 0 - this.height}, speed);
        } else if(direction == -1){
            y = 0 - this.height;
            visible = true;
            FlxTween.tween(this, {y: 0}, speed);
        } else {
            return;
        }
    }
}