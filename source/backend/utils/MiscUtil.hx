package backend.utils;

class MiscUtil
{
	public static function capitalize(string:String):String
	{
		var strArray:Array<String> = string.split(' ');
		var newArray:Array<String> = [];
		for (str in 0...strArray.length)
		{
			newArray.push(strArray[str].charAt(0).toUpperCase() + strArray[str].substring(1));
		}
		return newArray.join(' ');
	}
}
