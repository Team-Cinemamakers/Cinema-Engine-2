package funkinMain.systems;

import funkinMain.objects.Alphabet;

class ScrollableMenu extends FlxBasic
{
    public static var items:Array<String> = [];
	public static var menuItems:Array<Alphabet> = [];
	static var spacingMain:Float = 0;
	static var itemHeight:Float = 0;

	public var curItem:Int = 0;

	public function new(itemArray:Array<String>, height:Float, spacing:Float, y:Float)
	{
		super();
		
		items = itemArray;
		spacingMain = spacing;
		itemHeight = height;

        for(i in 0...items.length){
			var yIterator:Float = (i * (itemHeight + spacingMain)) + y;
			var newAlphabet = new Alphabet(items[i], i, 50, 0, yIterator, true);
			menuItems.push(newAlphabet);
			FlxG.state.add(newAlphabet);
        }
		menuItems[0].setScale(true);
	}
	public function scroll(value:Int)
	{
		menuItems[curItem].setScale(false);
		value *= -1;
		if (curItem + value >= menuItems.length)
		{
			curItem = 0;
		}
		else if (curItem + value < 0)
		{
			curItem = menuItems.length - 1;
		}
		else
		{
			curItem += value;
		}
		FlxG.sound.play(Paths.audio('audio/sounds/scrollMenu'));

		menuItems[curItem].setScale(true);

		trace("scroll");
	}
	public function selectDestroy()
	{
		trace('select');
		for (i in 0...menuItems.length)
		{
			for (j in 0...menuItems[i].length)
			{
				menuItems[i].members[j].destroy();
			}
			menuItems[i].destroy();
		}
	}
	public override function destroy()
	{
		super.destroy();

		trace('destroyed');
		// selectDestroy();
	}
}