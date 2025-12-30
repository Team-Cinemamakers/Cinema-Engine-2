package funkin.objects;

class Transition extends FlxSprite {

    public static final DOWN = 1;
    public static final UP = -1;

    public function new(visible:Bool = true, x:Float = 0, y:Float = 0, style:String = 'basic'){
        super(x, y);

        this.loadGraphic(Paths.image(style, 'images/shared/transitions', ENGINE));
        this.screenCenter(X);
        this.y = 0;
        this.visible = visible;
        
        this.zIndex = 10000;

    }

    public function play(direction:Int = 1, speed:Float = 0.5, ?endCallback:(()->Void)){
        if(direction == 1){
            y = 0;
            visible = true;
            var transitionTween = FlxTween.tween(this, {y: 0 - this.height}, speed);
            if (endCallback != null)
                transitionTween.onComplete = (twn) -> endCallback();

        } else if(direction == -1){
            y = 0 - this.height;
            visible = true;
            var transitionTween = FlxTween.tween(this, {y: 0}, speed);
            if (endCallback != null)
                transitionTween.onComplete = (twn) -> endCallback();
        } else {
            return;
        }
    }
}