package funkin.objects;

import backend.Paths;
import backend.shaders.NoteShader;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets;
import funkin.objects.LongNote;
import funkin.objects.Strumline;
import haxe.io.Scheme;

typedef NoteData =
{
	var time:Float; // Time at which the note is supposed to be pressed
	var type:Int; // Note type (0 for normal)
	var value:Int; // Value (corresponds to the place in the strumline, so on 4k its from 0-3 and on 7k its from 0-6 and so on)
	var length:Float;
}

class Note extends FlxSprite {
    
	public var noteData:NoteData;
	public var strumline:Strumline;

	var scaleX:Float;
	var scaleY:Float;

	public var yOFF:Float = 0;

	public var moving:Bool = false;
	var offsetNote:Float;
	public var strumnote:StrumNote;
	var tempNoScroll:Bool = false;

	var justMovedY:Float = 0;
	var justRecalc:Bool = false;

	var framesAdded:Bool = false;

	public var iterator:Int = 0;

	public var held:Bool = false;

	public var longNote:LongNote;

	public var input:String = "";

	public function new(angle:Float = 0, strumline:Strumline, noteData:NoteData, x:Float = 0, y:Float = 0, scaleX:Float, scaleY:Float, iterator:Int)
	{
		y = FlxG.height + this.height / 2;

        super(x, y);

		centerOrigin();
		centerOffsets();

		this.scaleX = scaleX;
		this.scaleY = scaleY;
		this.updateHitbox();

        this.angle = angle;
		this.noteData = noteData;

		this.iterator = iterator;

        this.strumline = strumline;
		this.frames = Paths.sparrow('notes', 'images/shared', ENGINE, this, true, true);

		this.scale.set(scaleX, scaleY);

		lastSS = PlayState.scrollSpeed;

		offsetNote = this.width / 4;
		strumnote = strumline.members[noteData.value];
		if(PlayState.instance != null){
			PlayState.instance.notesTypedGroup.add(this);
		}
		this.shader = strumnote.noteShader;
		x = strumnote.x + (this.width/4);
		this.yOFF = y - strumnote.y + (this.height/2);
	}

	var playedHitsound:Bool = false;
	var lastSS:Float = -1;
	override function update(elapsed:Float)
	{
		super.update(elapsed);


		if(y <= 0 - this.height && longNote == null){
				if(this.strumnote.playable){
					setCharactersLongNoteState(false);
					PlayState.instance.notesTypedGroup.remove(this, true);
					PlayState.instance.noteMiss(this, this.strumnote.input);
					this.destroy();
				} else {
					setCharactersLongNoteState(false);
					this.strumnote.pressedOnNote = true;
					PlayState.instance.activateEnemyNote(this.strumnote, this.noteData.value);
					PlayState.instance.notesTypedGroup.remove(this, true);
					this.destroy();
				}
				// #if desktop
				// Gc.run(true);
				// #end
			}

		if(y <= strumnote.y + (this.height/2)){
			if(!playedHitsound && moving){
				playedHitsound = true;
				if(!this.strumnote.playable){
					this.strumnote.pressedOnNote = true;
					PlayState.instance.activateEnemyNote(this.strumnote, this.noteData.value);
					if (this.longNote != null){
						this.alpha = 0;
						setCharactersLongNoteState(true);
					} else {
						setCharactersLongNoteState(false);
						PlayState.instance.notesTypedGroup.remove(this, true);
						this.destroy();
					}
					// #if desktop
					// Gc.run(true);
					// #end
				}
				//PlayState.hitsound.play(true);
			}
		}

		if(this.longNote != null && !CoolInput.held(this.strumnote.input) && this.held){
			if(this.strumnote.playable){
				this.held = false;
				if(this.longNote.members[this.longNote.length - 1].y >= strumnote.y + 60){
					PlayState.instance.notesTypedGroup.remove(this, true);
					PlayState.instance.noteMiss(this, this.strumnote.input);
					trace('missed long note');
					setCharactersLongNoteState(false);
            		this.longNote.destroy();
            		this.destroy();			
				} else {
					setCharactersLongNoteState(false);
					this.longNote.destroy();
					this.destroy();
				}
			} else {
				PlayState.instance.activateEnemyNote(this.strumnote, this.noteData.value);
				setCharactersLongNoteState(false);
				this.longNote.destroy();
            	this.destroy();
			}
		}
	}

	public function setCharactersLongNoteState(state:Bool){
		for (char in strumline.characters)
		{
			char.playingLongNote = state;
		}
	}

	public function clickedOnRow():Bool
	{
		if (MathUtil.isInRange(y, strumnote.y, 100))
		{
			return true;
		}
		else
			return false;
	}

	public override function draw()
	{
		if(moving){
			super.draw();
		}
	}

	public override function destroy(){
		PlayState.instance.noteMap.get(strumline).remove(this);
		super.destroy();
	}
}
