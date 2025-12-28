package funkin.objects;

typedef CharacterFile =
{
	var name:String;
	var icon:String;
	var offset:Array<Int>;
	var camOffset:Array<Int>;
	var fileName:String;
	var animations:Array<CharacterAnimation>;
}

typedef CharacterAnimation =
{
	var name:String;
	var prefix:Null<String>;
	var indices:Null<Array<Int>>;
	var offset:Array<Int>;
	var camOffset:Array<Int>;
	var fps:Int;
	var loop:Bool;
}

class Character extends FlxSprite
{
	public var name:String; // Display name of the character in places like chart editor
	public var icon:String;
	public var positionOffset:FlxPoint; // Same as offset in the char file // slippery slope -x8c8r
	public var cameraOffset:FlxPoint;
	public var fileName:String;
	// var animations:Map<String, CharacterAnimation>;
	public var animOffsets:Map<String, FlxPoint> = new Map<String, FlxPoint>();
	public var animCamOffsets:Map<String, FlxPoint> = new Map<String, FlxPoint>();
	public var script:HScript = null;

	public function new(character:String, x:Float = 0, y:Float = 0)
	{
		super(x, y);

		this.fileName = character;

		var file = load(character);

		this.name = file.name;
		this.icon = file.icon;
		this.positionOffset = new FlxPoint(file.offset[0], file.offset[1]);
		this.cameraOffset = new FlxPoint(file.camOffset[0], file.camOffset[1]);
		offset = positionOffset;

		offset.set(width/2, -height);

		frames = Paths.sparrow(character, "characters/" + character, false);

		for (anim in file.animations)
		{
			if (anim.indices != null)
				animation.addByIndices(anim.name, anim.prefix, anim.indices, "", anim.fps, anim.loop);
			else
				animation.addByPrefix(anim.name, anim.prefix, anim.fps, anim.loop);
			animOffsets[anim.name] = new FlxPoint(anim.offset[0], anim.offset[1]);
			animCamOffsets[anim.name] = new FlxPoint(anim.camOffset[0], anim.camOffset[1]);
		}

		setupScripting();

		// CALLBACK: create
		if (script != null)
			script.run("create");

		file = null;
	}

	function load(character)
	{
		var rawJson = JsonUtil.loadJson(Paths.json(character, "characters/" + character));
		var casted:CharacterFile = cast(Json.parse(rawJson));
		return casted;
	}

	/**
		Plays a specified animation for the character, if it exists.

		@param animation Animation name
		@param force Whether the animation should override the current animation
	**/
	public function playAnimation(animation:String, force:Bool = false)
	{
		if (animOffsets[animation] == null)
			return;
		offset = positionOffset + animOffsets[animation];
		this.animation.play(animation, force);

		// CALLBACK: playAnimation
		if (script != null) 
			script.run("playAnimation", [animation]);
	}

	public override function update(elapsed:Float) {
		super.update(elapsed);

		// CALLBACK: update
		if (script != null) 
			script.run("update", [elapsed]);
	}

	function setupScripting() {
		// Initiate character script
		if (Paths.exists(Paths.hscript(fileName, "characters/" + fileName))) {
			script = Scripts.create(fileName + "-character", Paths.hscript(fileName, "characters/" + fileName), ScriptContext.CHARACTER);

			script.set("character", this);
		}
	}

	public function getCameraPos(isPlayer:Bool = false) {
		var camPos = getMidpoint();

		if (isPlayer) {
			camPos.x -= 100 + cameraOffset.x;
			camPos.y += -100 + cameraOffset.y;
		} else {
			camPos.x += 150 + cameraOffset.x;
			camPos.y += -100 + cameraOffset.y;
		}

		return camPos;
	}
}
