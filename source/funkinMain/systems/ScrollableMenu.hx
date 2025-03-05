package funkinMain.systems;

import funkinMain.objects.Alphabet;
import openfl.net.Socket;

class ScrollableMenu {
    public static var items:Array<String> = [];
	public static var menuItems:Array<Alphabet> = [];
	static var spacingMain:Float = 0;
	static var itemHeight:Float = 0;

	public function new(itemArray:Array<String>, height:Float, spacing:Float, y:Float)
	{
		items = itemArray;
		spacingMain = spacing;
		itemHeight = height;

        for(i in 0...items.length){
			var yIterator:Float = (i * (itemHeight + spacingMain)) + y;
			trace(yIterator);
			var newAlphabet = new Alphabet(items[i], i, 50, 0, yIterator, true);
			menuItems.push(newAlphabet);
			FlxG.state.add(newAlphabet);
        }
	}
}