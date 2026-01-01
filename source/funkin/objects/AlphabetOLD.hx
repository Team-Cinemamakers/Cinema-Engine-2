package funkin.objects;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;

class AlphabetOld extends FlxSpriteGroup
{
	var ogHeight:Float = 0;
	//
	var letterX:Array<Float> = [];
	var letterXScaled:Array<Float> = [];
	var letterY:Array<Float> = [];
	var letterYScaled:Array<Float> = [];
	var scaleMain:Float = 0;
	var onSelectScale:Float = 0;

	public var yOffset:Float = 0;

	private var alphabetSparrow:FlxAtlasFrames = Paths.sparrow('images/shared/alphabet', "");
    //this isnt done
	public function new(text:String, index:Int, height:Float, x:Float = 0, y:Float = 0, xCentered:Bool = true, onSelectScale:Float = 1.2, bold:Bool = false)
	{
		super();

		this.onSelectScale = onSelectScale;

		for (i in 0...text.length)
		{
			var letter:FlxSprite = new FlxSprite();
			var char = text.charAt(i);

			letter.frames = alphabetSparrow;

			if(bold){
				var shit:String = char.toUpperCase() + " bold";
				letter.animation.addByPrefix('bruh', shit, 8, true);
				letter.animation.play('bruh', true);
				//
				var scaleVal:Float = height / letter.height;
				this.add(letter);
			} else if (Globals.alphabetLowercase.contains(char))
			{
				var shit:String = char + " lowercase";
				letter.animation.addByPrefix('bruh', shit, 8, true);
				letter.animation.play('bruh', true);
				//
				var scaleVal:Float = height / letter.height;
				this.add(letter);
			}
			else if (Globals.alphabetUppercase.contains(char))
			{
				var shit:String = char + " capital";
				letter.animation.addByPrefix('bruh', shit, 8, true);
				letter.animation.play('bruh', true);
				//
				var scaleVal:Float = height / letter.height;
				this.add(letter);
			}
			else
				return;
		}
		ogHeight = this.members[0].height;
		preloadPositioning(1, xCentered, x, y, height);
		preloadPositioning(onSelectScale, xCentered, x, y, height);
		setScale(false);
	}

	public function setScale(selected:Bool):Void
	{
		var scale:Float = 1;
		if (selected)
		{
			scale = onSelectScale;
			for (i in 0...letterXScaled.length)
			{
				this.members[i].scale.set(scaleMain * scale, scaleMain * scale);
				this.members[i].updateHitbox();

				this.members[i].x = letterXScaled[i];
				FlxTween.tween(this.members[i], {y: letterYScaled[i] - yOffset}, 0.3, {
					ease: FlxEase.quadInOut
				});
			}
		}
		else
		{
			for (i in 0...letterX.length)
			{
				this.members[i].scale.set(scaleMain * scale, scaleMain * scale);
				this.members[i].updateHitbox();

				this.members[i].x = letterX[i];
				FlxTween.tween(this.members[i], {y: letterY[i] - yOffset}, 0.3, {
					ease: FlxEase.quadInOut
				});
			}
		}
	}

	function preloadPositioning(scale:Float = 1, centered:Bool, desiredX:Float, desiredY:Float, heightMain:Float):Void
	{
		var totalLength:Float = 0;
		var scaleVal:Float = (heightMain / ogHeight) * scale;
		scaleMain = heightMain / ogHeight;
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
				if (scale == 1)
				{
					letterX[i] = this.members[i].x;
				}
				else
				{
					letterXScaled[i] = this.members[i].x;
				}
				totalLength -= this.members[i].width;
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
				if (scale == 1)
				{
					letterX[i] = desiredX + xShit;
				}
				else
				{
					letterXScaled[i] = desiredX + xShit;
				}
			}
		}

		for (i in 0...this.length)
		{
			if (i != 0)
			{
				this.members[i].y = this.members[i - 1].y + this.members[i - 1].height - this.members[i].height;
				if (scale == 1)
				{
					letterY[i] = (this.members[i - 1].y + this.members[i - 1].height - this.members[i].height);
				}
				else
				{
					letterYScaled[i] = (this.members[i - 1].y + this.members[i - 1].height - this.members[i].height);
				}
			}
			else
			{
				this.members[i].y = desiredY;
				if (scale == 1)
				{
					letterY[i] = desiredY;
				}
				else
				{
					letterYScaled[i] = desiredY;
				}
			}
			
		}
	}
}