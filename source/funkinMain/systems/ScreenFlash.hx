package funkinMain.systems;

class ScreenFlash extends FlxSprite{

    public function new(duration:Float = 0.15, play:Bool = true, autoDestroy:Bool = true){
        super(x, y);

        this.makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
        this.screenCenter();
        this.alpha = 0;
        FlxG.state.add(this);

        if(!play) return;
        this.play(duration, autoDestroy);
    }

    public function play(duration:Float, destroy:Bool):Void
    {
        this.alpha = 1;
        FlxTween.tween(this, {alpha: 0}, duration, {
            onComplete: function(twn:FlxTween) {
                if(destroy) this.destroy();
            }
        });
    }
}