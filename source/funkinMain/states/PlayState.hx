package funkinMain.states;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

        
	}
    
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}