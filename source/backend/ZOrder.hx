package backend;

class ZOrder{
	public static var backgroundLayer:Array<FlxTypedGroup<FlxBasic>> = [];
	public static var characterLayer:FlxTypedGroup<FlxBasic>;
	public static var foregroundLayer:Array<FlxTypedGroup<FlxBasic>> = [];
	public static var backgroundUILayer:Array<FlxTypedGroup<FlxBasic>> = [];
	public static var foregroundUILayer:Array<FlxTypedGroup<FlxBasic>> = [];
    public static var indexes:Int = 0;


    public function new(zIndexes:Int){
        initiateScreenSpace(zIndexes);
    }
    //adds zOrder sprite layers, allows modder to decide to increase zIndexes per layer if desired
    public static function initiateScreenSpace(zIndexes:Int){
        for(i in 0...zIndexes){
			backgroundLayer.push(new FlxTypedGroup<FlxBasic>());
			foregroundLayer.push(new FlxTypedGroup<FlxBasic>());
			backgroundUILayer.push(new FlxTypedGroup<FlxBasic>());
			foregroundUILayer.push(new FlxTypedGroup<FlxBasic>());
        }

		characterLayer = new FlxTypedGroup<FlxBasic>();

        indexes = zIndexes;

        trace("Done Initializing ZOrder");
    }

    //this NEEDS to be in every state that uses zOrdering
    public static function addScreenSpace(state:FlxState){
        for(i in 0...indexes){
            state.add(backgroundLayer[i]);
            state.add(characterLayer);
            state.add(foregroundLayer[i]);
            state.add(backgroundUILayer[i]);
            state.add(foregroundUILayer[i]);
        }
    }

    //creating seperate functions for the additions to prevent needing an int or string argument (to simplify zOrdering for not just us but other developers)
    public static function addToBackground(spr:FlxSprite, zOrder:Int){
        if(backgroundLayer[zOrder] == null) return;

        backgroundLayer[zOrder].add(spr);
        trace("added BG Sprite");
    }

    public static function addToCharacters(spr:FlxSprite){
        if(characterLayer == null) return;

        characterLayer.add(spr);
        trace("added char Sprite");
    }

    public static function addToForeground(spr:FlxSprite, zOrder:Int){
        if(foregroundLayer[zOrder] == null) return;

        foregroundLayer[zOrder].add(spr);
        trace("added foreground Sprite");
    }

    public static function addToUIBackground(spr:FlxSprite, zOrder:Int){
        if(backgroundUILayer[zOrder] == null) return;

        backgroundUILayer[zOrder].add(spr);
        trace("added UI BG Sprite");
    }

    public static function addToUIForeground(spr:FlxSprite, zOrder:Int){
        if(foregroundUILayer[zOrder] == null) return;

        foregroundUILayer[zOrder].add(spr);
        trace("added UI FG Sprite");
    }

    //this runs thru all the arrays and destroys all the sprites to save ram usage
    //may be a slow function but overall should save performance majorly instead of running killMembers
    public static function flushSprites(){
        for(i in 0...4){
			var clearArray:Array<FlxTypedGroup<FlxBasic>>;
            switch(i){
                case 0:
                    clearArray = backgroundLayer;
                case 1:
                    clearArray = foregroundUILayer;
                case 2:
                    clearArray = foregroundLayer;
                case 3:
                    clearArray = backgroundUILayer;
                default:
                    //to shut up syntax
					clearArray = new Array<FlxTypedGroup<FlxBasic>>();
                    return;
            }

            //syntax will yell that its not initialized (it is) but it will build fine
            if(clearArray == null) return;

            for(j in 0...clearArray.length){
                for(k in 0...clearArray[j].length){
                    clearArray[j].members[k].destroy();
                }
                clearArray[j].clear();
            }
        }
        for(i in 0...characterLayer.length){
            characterLayer.members[i].destroy();
        }
        characterLayer.clear();
    }
}