package funkinMain.systems;

import funkinMain.objects.Alphabet;

class ScrollableMenu {
    public static var items:Array<String> = [];
	public static var menuItems:Array<Alphabet> = [];

    //this is also not done
    public static function addToScreen(itemArray:Array<String>){
        items = itemArray;
        for(i in 0...items.length){
			menuItems.push(new Alphabet(items[i], i, 20, 50, 0, 0, true));
        }
    }
}