package backend;

typedef InputEvent =
{
	var inputName:String;
	var inputKey:String;
}
class Input
{
	public static var mainInputJson:String = JsonFunctions.loadJson("controls/controls");
	static var inputs:Dynamic = Json.parse(mainInputJson);

	public static var inputEvents:Array<InputEvent>;

	// if you wanna try to do this go ahead, i aint fucking with it no more for now
	
	public static function loadInputs()
	{
		for (i in 0...inputs.controls.length)
		{
			// var newInput:InputEvent = {inputName: inputs.controls[i].name, inputKey: inputs.controls[i].defaultKey};
			// inputEvents.push(newInput);
		}
	}
}