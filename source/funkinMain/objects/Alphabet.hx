package funkinMain.objects;

class Alphabet extends FlxTypedGroup<FlxSprite>
{
    //this isnt done
	public function new(text:String, index:Int, spacing:Float, height:Float, x:Float = 0, y:Float = 0, xCentered:Bool)
	{
		super();

		for (i in 0...text.length)
		{
			var letter:FlxSprite = new FlxSprite();
			var char = text.charAt(i);

			letter.frames = Paths.sparrow('images/shared/alphabet');

			if (StaticVariables.alphabetLowercase.contains(char))
			{
				var shit:String = char + " lowercase";
				letter.animation.addByPrefix('bruh', shit, 0, false);
				this.add(letter);
				letter.animation.play('bruh', true);
			}
			else if (StaticVariables.alphabetUppercase.contains(char))
			{
				var shit:String = char + " capital";
				letter.animation.addByPrefix('bruh', shit, 0, false);
				this.add(letter);
				letter.animation.play('bruh', true);
			}
			else
				return;

			if (i == text.length - 1) {}
		}
    }
}