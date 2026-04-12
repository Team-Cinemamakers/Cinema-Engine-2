package funkin.states;
import backend.options.FunkinOption;
import backend.options.Options;
import funkin.objects.Alphabet;
import funkin.states.MainMenuState;

class OptionsMenu extends FlxState{
    var curSelected:Int = 0;
    var optionsObjects:Array<backend.options.FunkinOption>;
    var bg:FlxSprite;
    var menuOptions:FlxTypedGroup<Alphabet>;

    override public function create(){
        super.create();
        
		bg = new FlxSprite().loadGraphic(Paths.image("menuBG", 'images/states/mainMenu', ENGINE));
		bg.screenCenter();
		add(bg);

		menuOptions = new FlxTypedGroup<Alphabet>();
		add(menuOptions);

        optionsObjects = Options.getAllOptions();
        
        for(i in 0...optionsObjects.length){
            var option = optionsObjects[i];
            var optionText = option.name + ": " + option.value;
            var item:Alphabet = new Alphabet(0, (i * 50) + 100, optionText, 40);
            menuOptions.add(item);
        }
    }

    var optionDeb:Float = 0;

    override public function update(elapsed:Float){
        super.update(elapsed);
        optionDeb += elapsed;

        for(i in 0...optionsObjects.length){
            if(menuOptions.members[i] != null){
                if(i == curSelected){
                    menuOptions.members[i].alpha = 1;
                } else {
                    menuOptions.members[i].alpha = 0.5;
                }
            }
        }

        if (CoolInput.pressed("return"))
        {
            FlxG.switchState(() -> new MainMenuState());
        }

        if(CoolInput.pressed("uiLeft") && optionDeb > 0.2)
        {
            optionDeb = 0;
            var option = optionsObjects[curSelected];
            if(option.enumType == OptionType.BOOL){
                option.value = !option.value;
            } else if(option.enumType == OptionType.INT){
                if(option.value > option.min) option.value -= 1;
            } else if(option.enumType == OptionType.FLOAT){
                if(option.value > option.min) option.value -= 0.1;
            } else if(option.options.length > 0){
                var currentIndex = option.options.indexOf(option.value);
                var newIndex = (currentIndex - 1 + option.options.length) % option.options.length;
                option.value = option.options[newIndex];
            }
            menuOptions.members[curSelected].changeText(option.name + ": " + option.value);
        }

        if(CoolInput.pressed("uiRight") && optionDeb > 0.2)
        {
            optionDeb = 0;
            var option = optionsObjects[curSelected];
            if(option.enumType == OptionType.BOOL){
                option.value = !option.value;
            } else if(option.enumType == OptionType.INT){
                if(option.value < option.max) option.value += 1;
            } else if(option.enumType == OptionType.FLOAT){
                if(option.value < option.max) option.value += 0.1;
            } else if(option.options.length > 0){
                var currentIndex = option.options.indexOf(option.value);
                var newIndex = (currentIndex + 1) % option.options.length;
                option.value = option.options[newIndex];
            }
            menuOptions.members[curSelected].changeText(option.name + ": " + option.value);
        }
        
        if(CoolInput.pressed("uiUp"))
        {
            if(curSelected > 0)
            {
                curSelected--;
            } else {
                curSelected = optionsObjects.length - 1;
            }
        }
        
        if(CoolInput.pressed("uiDown"))
        {
            if(curSelected < optionsObjects.length - 1)
            {
                curSelected++;
            } else {
                curSelected = 0;
            }
        }
    }
}