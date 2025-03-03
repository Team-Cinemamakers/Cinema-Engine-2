package backend;

typedef InputAction = {
    var name:String;
    var key:String;
}

var inputs:Array<InputAction>;

class Input
{
    public static var mainInputJson:String = JsonFunctions.loadJson("controls/controls");
}