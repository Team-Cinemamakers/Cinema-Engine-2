package backend;

import funkin.objects.Note;
import funkin.objects.StrumNote;
import funkin.objects.Strumline;

class NoteHandler{
    public static function runNoteCheck(notes:Map<Strumline, Array<Note>>):Void{
        for(noteArr in notes){
            for(i in 0...noteArr.length){
                if(noteArr[i] != null){
                    var note = noteArr[i];
                    var curY:Float = note.y;
                        if(note.noteData.time - ((note.startY - (note.strumnote.y + (note.height/2)))/(PlayState.scrollSpeed * (1/FlxG.updateFramerate))) * ((1/FlxG.updateFramerate) * 1000) <= Conductor.TIME){
                            note.moving = true;
                            note.y = note.strumnote.y + (note.height/2) + ((note.noteData.time - Conductor.TIME)/(((1/FlxG.updateFramerate) * 1000)) * (PlayState.scrollSpeed * (60/FlxG.updateFramerate)));
                            if(note.y < note.strumnote.y + (note.height)){
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