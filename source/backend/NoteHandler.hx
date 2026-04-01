package backend;

import funkin.objects.LongNote;
import funkin.objects.Note;
import funkin.objects.StrumNote;
import funkin.objects.Strumline;

class NoteHandler{
    static var fuckingStop:Bool = false;
    static var averageFrameMS:Float = -1;

    public static function runNoteCheck(notes:Map<Strumline, Array<Note>>, elapsed:Float):Void{
        if(averageFrameMS == -1){
            averageFrameMS = (1/FlxG.updateFramerate);
        }
        fuckingStop = false;
        for(noteArr in notes){
            for(i in 0...noteArr.length){
                if(noteArr[i] != null){
                    var note = noteArr[i];
                    var curY:Float = note.y;
                        if(note.noteData.time - ((note.yOFF)/(PlayState.scrollSpeed * averageFrameMS)) * (averageFrameMS * 1000) <= Conductor.TIME || note.noteData.time - (((FlxG.height - note.height * 0.5) - (note.strumnote.y + (note.height * 0.5)))/(PlayState.scrollSpeed * averageFrameMS)) * (averageFrameMS * 1000) <= Conductor.TIME){
                            if(!fuckingStop){
                                if(note.moving == false){
                                    note.alive = true;
                                    note.x = note.strumnote.x + (note.width/4);
                                    note.moving = true;
                                }
                                //note.y = note.strumnote.y + (note.height * 0.5) + (0.5 * ((Conductor.TIME + Conductor.deltaOffset) - note.noteData.time) * PlayState.scrollSpeed);
                                note.y = note.strumnote.y + (note.height * 0.5) + ((note.noteData.time - (Conductor.TIME + Conductor.deltaOffset))/((averageFrameMS * 1000)) * (PlayState.scrollSpeed * (averageFrameMS * 60)));
                                if(note.longNote == null && note.noteData.length > 0){
                                    note.longNote = new LongNote(note);
                                    note.longNote.cameras = note.cameras;
                                    note.longNote.zIndex = ZLayers.UI+1;
                                    SortUtil.reorder();
                                    PlayState.instance.add(note.longNote);
                                }
                                if((note.y < note.strumnote.y + (note.height)) || MathUtil.isInRange(note.x, note.strumnote.x + (note.width/4), 10)){
                                    note.x = note.strumnote.x + (note.width/4);
                                } else {
                                    note.x += ((note.strumnote.x + (note.width/4)) - note.x)/((note.noteData.time - Conductor.TIME)/((1/FlxG.updateFramerate) * 1000));
                                }
                            }
                        } else {
                            fuckingStop = true;
                            note.moving = false;
                            break;
                        }   
                }
            }
        }
    }
}