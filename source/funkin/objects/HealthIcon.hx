package funkin.objects;

class HealthIcon extends FlxSprite {

    public var isPlayer:Bool = false;
    public var char:String = "face";
    private var firstTime:Bool = true; // to make sure that you can at least CREATE the icon

    public function new(char:String = 'face', isPlayer:Bool = false, x:Float = 0, y:Float = 0) {
        super(x, y);

        this.char = char;
        this.isPlayer = isPlayer;

        changeIcon(char);
        scrollFactor.set();
    }

    public function changeIcon(char2:String) {
        if (char == char2 && !firstTime) return; // fuck you if you try to do it forever and ever and ever

        var graphic = "";
        if (Paths.exists(Paths.image("icon-"+char2, "images/shared/icons", ENGINE))) graphic = Paths.image("icon-"+char2, "images/shared/icons", ENGINE);
        else if ((Paths.exists(Paths.image("icon-"+char2, "images/shared/icons", CONTENT)))) graphic = Paths.image("icon-"+char2, "images/shared/icons", CONTENT);
        else graphic = Paths.image("icon-face", "images/shared/icons", ENGINE);

        loadGraphic(graphic, true, 150, 150); // 150x150 is temporary until we get an automated system.

        animation.add(char2, [0, 1], 0, false, isPlayer);
        animation.play(char2);

        if (char2.endsWith('-pixel')) antialiasing = false;
        else antialiasing = true;

        char = char2;
        firstTime = false;
    }
}