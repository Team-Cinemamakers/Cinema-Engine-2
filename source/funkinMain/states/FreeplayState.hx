package funkinMain.states;

import funkinMain.data.Freeplay.FreeplayData;
import funkinMain.data.Freeplay;
import funkinMain.objects.Alphabet;
import funkinMain.objects.Transition;
import funkinMain.states.PlayState;

class FreeplayState extends FlxState{
    var bg:FlxSprite;
    var freeplayOptions:FlxTypedGroup<Alphabet>;
    var freeplayYValues:Array<Float> = [];
    var transition:Transition;

    var freeplay:FreeplayData;
    var freeplayLength:Int = 0;

    var curItem:Int = 0;

    override public function create(){
        super.create();
        Gc.run(true);

        if (!FlxG.sound.music.playing || FlxG.sound.music == null)
            {
                FlxG.sound.playMusic(Paths.audio('audio/music/freakyMenu'));
            }

		bg = new FlxSprite().loadGraphic(Paths.stateImage("mainMenu/menuBG"));
		bg.screenCenter();
		add(bg);

        freeplay = Freeplay.loadFreeplay();

        freeplayOptions = new FlxTypedGroup<Alphabet>();
		add(freeplayOptions);

		for (i in 0...freeplay.sections.length)
		{
            for(k in 0...freeplay.sections[i].songs.length){
                var yIterator:Float = ((i + 1) * (k * (100 + 75)) + 62.5);
                var newAlphabet = new Alphabet(freeplay.sections[i].songs[k].name, k * (i + 1), 50, 0, yIterator, true, true);
                freeplayOptions.add(newAlphabet);
                add(newAlphabet);
                freeplayYValues.push(yIterator - newAlphabet.height);
                freeplayLength++;
            }
		}
		freeplayOptions.members[0].setScale(true);

        transition = new Transition();
		add(transition);
		transition.play(1);
    }

    override public function update(elapsed:Float)
        {
            super.update(elapsed);
    
            // gets input from custom input callouts (CoolInput) and checks if it is just pressed
            if (CoolInput.pressed("accept"))
            {
                transition.play(-1);
                new FlxTimer().start(1.5, function(tmr:FlxTimer){
                    PlayState.loadedSong = freeplay.sections[0].songs[curItem].name;
                    FlxG.switchState(() -> new PlayState());
                });
            }
            if (CoolInput.pressed("uiDown"))
            {
                scroll(-1);
            }
            else if (CoolInput.pressed("uiUp"))
            {
                scroll(1);
            }
            if(FlxG.sound.music != null){
                Conductor.setConductorTime(FlxG.sound.music.time, this);
            }
        }

    	public function scroll(value:Int)
            {
                var ogCurItem:Int = curItem;
                
                value *= -1;
                if (curItem + value >= freeplayLength)
                {
                    curItem = 0;
                }
                else if (curItem + value < 0)
                {
                    curItem = freeplayLength - 1;
                }
                else
                {
                    curItem += value;
                }

                for(i in 0...freeplayOptions.length){
                    freeplayOptions.members[i].yOffset = 175 * curItem;
                    if(i != curItem){
                        freeplayOptions.members[i].setScale(false);
                    }
                }
        
                freeplayOptions.members[curItem].setScale(true);

                FlxG.sound.play(Paths.audio('audio/sounds/scrollMenu'));
            }
}