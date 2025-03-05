package funkinMain.objects;

class Alphabet extends FlxTypedGroup<FlxSprite>
{
	var totalLength:Float = 0;
	var centered:Bool = true;
	var desiredX:Float = 0;
	var desiredY:Float = 0;

	var heightMain:Float = 0;
    //this isnt done
	public function new(text:String, index:Int, height:Float, x:Float = 0, y:Float = 0, xCentered:Bool = true)
	{
		super();

		centered = xCentered;
		desiredX = x;
		desiredY = y;

		heightMain = height;

		for (i in 0...text.length)
		{
			var letter:FlxSprite = new FlxSprite();
			var char = text.charAt(i);

			letter.frames = Paths.sparrow('images/shared/alphabet');

			if (StaticVariables.alphabetLowercase.contains(char))
			{
				var shit:String = char + " lowercase";
				letter.animation.addByPrefix('bruh', shit, 0, false);
				letter.animation.play('bruh', true);
				//
				var scaleVal:Float = height / letter.height;
				this.add(letter);
			}
			else if (StaticVariables.alphabetUppercase.contains(char))
			{
				var shit:String = char + " capital";
				letter.animation.addByPrefix('bruh', shit, 0, false);
				letter.animation.play('bruh', true);
				//
				var scaleVal:Float = height / letter.height;
				this.add(letter);
			}
			else
				return;
		}

		setPositioning();
	}

	function setPositioning():Void
	{
		var scaleVal:Float = heightMain / this.members[0].height;
		for (i in 0...this.length)
		{
			this.members[i].scale.set(scaleVal, scaleVal);
			this.members[i].updateHitbox();

			totalLength += this.members[i].width;
		}

		if (centered)
		{
			var halfLength:Float = totalLength / 2;
			for (i in 0...this.length)
			{
				this.members[i].x = (FlxG.width / 2 - totalLength) + halfLength;
				totalLength -= this.members[i].width;

				trace(FlxG.width / 2 - totalLength / 2);
			}
		}
		else
		{
			for (i in 0...this.length)
			{
				var xShit:Float = 0;
				if (i != 0)
				{
					for (j in 0...i)
					{
						xShit += this.members[j].width;
					}
				}
				this.members[i].x = desiredX + xShit;
			}
		}

		for (i in 0...this.length)
		{
			if (i != 0)
			{
				this.members[i].y = this.members[i - 1].y + this.members[i - 1].height - this.members[i].height;
			}
			else
			{
				this.members[i].y = desiredY;
			}
			
		}
	}
}