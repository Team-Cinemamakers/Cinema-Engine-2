package funkinMain.objects;

import backend.Paths;
import funkinMain.objects.Strumline;

class Note extends FlxSprite {
    
    public var noteData:Int;
    public var noteType:Int;
    public var strumline:Strumline;

    public function new(angle:Float = 0, strumline:Strumline, noteData:Int = 0, noteType = 0, x:Float = 0, y:Float = 0) {
        super(x, y);

        this.angle = angle;
        this.noteData = noteData;
        this.noteData = noteType;

        this.strumline = strumline;

        x = strumline.members[noteData].x;

        // y += strumline.members[noteData].y;

        frames = Paths.sparrow('images/shared/notes');

		animation.addByPrefix('note', 'noteUp', 24);
		animation.play('note', true);
        
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        x = strumline.members[noteData].x;
    }
}