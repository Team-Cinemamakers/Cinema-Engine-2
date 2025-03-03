package funkinMain.states;

class MainMenu extends FlxState
{
	var bg:FlxSprite;

	override public function create()
	{
		super.create();

		FlxG.autoPause = false;

		if(FlxG.sound.music == null){
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		bg = new FlxSprite().loadGraphic(Paths.stateAssets("mainMenu/menuBG"));
		bg.screenCenter();
		add(bg);
	}

	override public function update(elapsed:Float)
	{
		if (CoolInput.pressed("enter"))
		{
			FlxG.switchState(PlayState);
		}
		super.update(elapsed);
	}
}
