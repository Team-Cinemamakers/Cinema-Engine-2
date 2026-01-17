package backend;

import funkin.objects.LongNote;
import funkin.objects.Note;
import funkin.objects.StrumNote;
import funkin.objects.Strumline;

class NoteHandler{
    public static function runNoteCheck(notes:Map<Strumline, Array<Note>>, elapsed:Float):Void{
        for(noteArr in notes){
            for(i in 0...noteArr.length){
                if(noteArr[i] != null){
                    var note = noteArr[i];
                    var curY:Float = note.y;
                        if(note.noteData.time - ((note.yOFF)/(PlayState.scrollSpeed * (1/FlxG.updateFramerate))) * ((1/FlxG.updateFramerate) * 1000) <= Conductor.TIME || note.noteData.time - (((FlxG.height - note.height * 0.5) - (note.strumnote.y + (note.height * 0.5)))/(PlayState.scrollSpeed * (1/FlxG.updateFramerate))) * ((1/FlxG.updateFramerate) * 1000) <= Conductor.TIME){
                            if(note.moving == false){
                                note.x = note.strumnote.x + (note.width/4);
                                note.moving = true;
                            }
                            note.y = note.strumnote.y + (note.height * 0.5) + ((note.noteData.time - Conductor.TIME)/(((1/FlxG.updateFramerate) * 1000)) * (PlayState.scrollSpeed * (60/FlxG.updateFramerate)));
                            if(note.longNote == null && note.noteData.length > 0){
                                note.longNote = new LongNote(note);
                                note.longNote.cameras = note.cameras;
                                note.longNote.zIndex = note.zIndex-1;
                                SortUtil.reorder();
                                PlayState.instance.add(note.longNote);
			                }
                            if((note.y < note.strumnote.y + (note.height)) || MathUtil.isInRange(note.x, note.strumnote.x + (note.width/4), 10)){
                                note.x = note.strumnote.x + (note.width/4);
                            } else {
                                note.x += ((note.strumnote.x + (note.width/4)) - note.x)/((note.noteData.time - Conductor.TIME)/((1/FlxG.updateFramerate) * 1000));
                            }
                        } else {
                            note.moving = false;
                            break;
                        }   
                }
            }
        }
    }
}