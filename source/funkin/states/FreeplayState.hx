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

    var tempOptions:Map<Alphabet, String> = new Map<Alphabet, String>();
    var options:Array<Alphabet> = [];

    var freeplay:FreeplayData;
    var freeplayLength:Int = 0;

    var curItem:Alphabet;

    override public function create(){
        super.create();

        if (!FlxG.sound.music.playing || FlxG.sound.music == null)
            {
                FlxG.sound.playMusic(Paths.audio('audio/music/freakyMenu'));
            }

		bg = new FlxSprite().loadGraphic(Paths.image("menuBG", "images/states/mainMenu", ENGINE));
		bg.screenCenter();
		add(bg);

        freeplay = Freeplay.loadFreeplay();

		for (i in 0...freeplay.sections.length)
		{
            for(k in 0...freeplay.sections[i].songs.length){
                var name:String = freeplay.sections[i].songs[k].name;
                var option:Alphabet = new Alphabet(0, 0, freeplay.sections[i].songs[k].displayName, 45);
                option.screenCenter(Y);
                option.x = 50;
                if(i != 0 || k != 0){
                    option.x = options[0].x + (30 * ((i + 1) * k));
                    option.y = options[0].y + (freeplayLength * 80);
                } 
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
        var lastCur:Alphabet = curItem;
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
        var tweenedx:Float = options[options.indexOf(curItem)].x - lastCur.x;
        var tweenedy:Float = options[options.indexOf(curItem)].y - ((FlxG.height/2) - (options[options.indexOf(curItem)].height/2));
        for(i in 0...options.length){
            var tx:Float = options[i].x - tweenedx;
            var ty:Float = options[i].y - tweenedy;
            FlxTween.tween(options[i], {x: tx, y: ty}, 0.3, {
                ease: FlxEase.quadInOut
            });
        }
        curItem.alpha = 1;
    }
}