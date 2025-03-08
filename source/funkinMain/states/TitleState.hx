package funkinMain.states;

import backend.events.*;
import cpp.vm.Gc;

class TitleState extends FlxState{

    var titleFinished:Bool = false;
    var introText:FlxTypedGroup<FlxText>;
    static var coolTextHeight:Int = 46;
    static var coolTextSpacing:Float = 20;

    var titleBump:FlxSprite;
    var gf:FlxSprite;
    var titleEnter:FlxSprite;

	var screenFlashMain:ScreenFlash;

    var selected:Bool = false;

	var bopDeb:Bool = false;

    static var path:String = 'images/stateAssets/titleState/';

    override public function create(){
        super.create();

        if(FlxG.sound.music == null){
			FlxG.sound.playMusic(Paths.audio('audio/music/freakyMenu'));
		}

        titleBump = new FlxSprite();
        titleBump.frames = Paths.sparrow(path + 'logoBumpin');
        titleBump.animation.addByPrefix("bump", 'logo bumpin', 24, false);
        titleBump.scale.set(0.75, 0.75);
        titleBump.updateHitbox();
        titleBump.x = -25;
        titleBump.y = -25;

        gf = new FlxSprite();
        gf.frames = Paths.sparrow(path + 'gfDanceTitle');
        gf.animation.addByPrefix("dance", 'gfDance', 24, false);
        gf.scale.set(0.85, 0.85);
        gf.updateHitbox();
        gf.x = FlxG.width - gf.width - 10;
        gf.y = FlxG.height - gf.height - 40;

        titleEnter = new FlxSprite();
        titleEnter.frames = Paths.sparrow(path + 'titleEnter');
        titleEnter.animation.addByPrefix("idle", 'ENTER IDLE', 24, false);
        titleEnter.animation.addByPrefix("pressed", 'ENTER PRESSED', 24, true);
        titleEnter.x = 150;
        titleEnter.y = FlxG.height - titleEnter.height - 20;

        Conductor.start(102);

        Conductor.evDisp.addEventListener(Conductor.beatEvent.type, beatHit);
    }

    override public function update(elapsed:Float)
        {
            super.update(elapsed);
    
            if (CoolInput.pressed("accept"))
            {
                if(titleFinished && !selected){
                    selected = true;
				screenFlashMain.play(0.15, true);
                    titleEnter.animation.play('pressed');
                    Conductor.evDisp.removeEventListener(Conductor.beatEvent.type, beatHit);
				FlxG.sound.play(Paths.audio('audio/sounds/confirmMenu'));
				// for some reason visual studio wants this indented back and it wont let me stop it
				// preloading the main menu before the timer to stop stuttering
                    new FlxTimer().start(1, function(tmr:FlxTimer){
					Gc.run(true);
					FlxG.switchState(() -> new MainMenu());
                    });
                } else if (!selected){
                    skipIntro();
                }
            }
            Conductor.addConductorTime(elapsed, this);
        }

    function beatHit(e:BeatEvent)
    {
        if(!titleFinished){
            switch (Conductor.curBeat){
                case 2:
					makeIntroText("Made By", true);
                case 4:
					makeIntroText("Team CinemaMakers");
				case 5:
					removeIntroText();
				case 6:
					makeIntroText("Original By", true);
				case 8:
					makeIntroText("Terrible Developers IDK");
				case 9:
                    removeIntroText();
				case 10:
					makeIntroText("I", true);
				case 12:
					makeIntroText("FART");
				case 13:
					removeIntroText();
					makeIntroText("FRIDAY", true);
				case 14:
					makeIntroText("NIGHT");
				case 15:
					makeIntroText("FUCKING");
				case 16:
                    skipIntro();
            }
        } else {
            if(titleBump != null) titleBump.animation.play("bump", true);
			if (!bopDeb)
				gf.animation.play("dance", true);
			bopDeb = !bopDeb;
        }
        trace("I DID IT");
    }

    function skipIntro(){
        removeIntroText();
        titleFinished = true;

        add(titleBump);
        add(gf);
        add(titleEnter);
		screenFlashMain = new ScreenFlash(0.15, true, false);
    }

    //someone get the fnf font and apply formatting pls
	function makeIntroText(string:String, createNewTypedGroup:Bool = false)
	{
		if (createNewTypedGroup)
		{
			introText = new FlxTypedGroup<FlxText>();
			add(introText);
		}

		var newText:FlxText = new FlxText(0, 0, 0, string, coolTextHeight, true);
        newText.screenCenter(X);
		introText.add(newText);
        reposIntroText();
    }
    function removeIntroText(){
		if (introText != null)
			introText.destroy();
    }

    function reposIntroText(){
        var heightTotal:Float = (coolTextHeight * introText.length) + (coolTextSpacing * (introText.length - 1));
        for(i in 0...introText.length){
            introText.members[i].y = (FlxG.height/2) - (heightTotal/2) + (i*(coolTextSpacing + coolTextHeight));
        }
    }
}