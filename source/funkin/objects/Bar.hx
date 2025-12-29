package funkin.objects;

import flixel.group.FlxSpriteGroup;
import funkin.states.PlayState;
import funkin.states.PlayState;

class Bar extends FlxSpriteGroup{
    public var value:Float = 0;
    var bounds:FlxPoint;
    var percentage:Float = 0;
    var barWidth:Int = 400;
    var barHeight:Int = 30;

    var barColors:Array<FlxColor> = [];

    private var leftBar:FlxSprite;
    private var rightBar:FlxSprite;

    public function new(width:Int, height:Int, ?colors:Array<FlxColor> = null, ?upperBound:Float = 1, ?defaultValue:Float = 0, ?lowerBound:Float = 0, ?x:Float = 0, ?y:Float = 0){
        super(x, y);

        this.barWidth = width;
        this.barHeight = height;

        this.bounds = FlxPoint.get(lowerBound, upperBound);
        this.value = defaultValue;
        this.percentage = this.value/(this.bounds.y - this.bounds.x);
        if (colors == null){
            this.barColors = [0xFFFF0000, 0xFF0000FF];
        } 
        else{
            this.barColors = colors;
        } 

        this.leftBar = new FlxSprite().makeGraphic(this.barWidth, this.barHeight, barColors[0]);
        this.leftBar.x = x;
        this.leftBar.y = y;
        this.add(this.leftBar);

        this.rightBar = new FlxSprite().makeGraphic(this.barWidth, this.barHeight, barColors[1]);
        this.rightBar.scale.set(this.percentage, 1);
        this.rightBar.updateHitbox();
        this.rightBar.x = this.leftBar.x + this.leftBar.width - this.rightBar.width;
        this.rightBar.y = y;
        this.add(this.rightBar);
    }

    override function update(elapsed:Float)
	{
		super.update(elapsed);

        this.percentage = this.value/(this.bounds.y - this.bounds.x);
        this.rightBar.scale.set(this.percentage, 1);
        this.rightBar.updateHitbox();
        this.rightBar.x = this.leftBar.x + this.leftBar.width - this.rightBar.width;
    }
}