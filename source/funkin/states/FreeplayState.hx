package funkin.states;

import funkin.data.Freeplay.FreeplayData;
import funkin.data.Freeplay;
import funkin.objects.Alphabet;
import funkin.objects.Transition;
import funkin.states.MainMenuState;
import funkin.states.PlayState;
import haxe.io.ArrayBufferView.ArrayBufferViewImpl;

class FreeplayState extends FlxState{
    var bg:FlxSprite;
    var freeplayYValues:Array<Float> = [];
    var transition:Transition;

    var tempOptions:Map<FlxText, String> = new Map<FlxText, String>();
    var options:Array<FlxText> = [];

    var freeplay:FreeplayData;
    var freeplayLength:Int = 0;

    var curItem:FlxText;

    override public function create(){
        super.create();

        if (!FlxG.sound.music.playing || FlxG.sound.music == null)
            {
                FlxG.sound.playMusic(Paths.audio('audio/music/freakyMenu'));
            }

		bg = new FlxSprite().loadGraphic(Paths.image("menuBG", "images/states/mainMenu", ENGINE));
		bg.screenCenter();
		add(bg);

        var alphaber:Alphabet = new Alphabet(0, 0, "holy shit", 70);
        add(alphaber);

        freeplay = Freeplay.loadFreeplay();

		for (i in 0...freeplay.sections.length)
		{
            for(k in 0...freeplay.sections[i].songs.length){
                var name:String = freeplay.sections[i].songs[k].name;
                var option:FlxText = new FlxText(0, 0, 0, freeplay.sections[i].songs[k].displayName, 50, true);
                option.setFormat(null, 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE_FAST, FlxColor.BLACK);
                option.screenCenter(X);
                option.y = 100 + (freeplayLength * 75);
                tempOptions.set(option, name);
                options.push(option);
                freeplayLength++;
                if(i == 0 && k == 0){
                    option.alpha = 1;
                    curItem = option;
                } else {
                    option.alpha = 0.5;
                }
                add(option);
            }
		}

        transition = new Transition();
		add(transition);
		transition.play(Transition.DOWN);
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        if (CoolInput.pressed("uiDown"))
		{
			change(1);
		}
		else if (CoolInput.pressed("uiUp"))
		{
			change(-1);
		} else if (CoolInput.pressed("return")){
			transition.play(Transition.UP, 0.5, () -> {
                FlxG.switchState(() -> new MainMenuState());
            });
		}

        if (CoolInput.pressed("accept"))
		{
            PlayState.loadedSong = tempOptions.get(curItem);
			FlxG.switchState(() -> new PlayState());
		}
    }


    public function change(dir:Int = 1){
        if(curItem == null) return;
        curItem.alpha = 0.5;
        if(options[options.indexOf(curItem) + dir] != null){
            curItem = options[options.indexOf(curItem) + dir];
        } else {
            if(dir == 1){
                curItem = options[0];
            } else if (dir == -1){
                curItem = options[options.length - 1];
            }
        }
        curItem.alpha = 1;
    }
}