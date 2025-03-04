package funkinMain.objects;

class Alphabet
{
    public static var letters:FlxTypedGroup<FlxSprite>;

    //this isnt done
	public function new(text:String, index:Int, spacing:Float, height:Float, x:Float = 0, y:Float = 0, xCentered:Bool)
	{
		for (i in 0...text.length)
		{
			var letter = new FlxSprite();
		}
    }
}