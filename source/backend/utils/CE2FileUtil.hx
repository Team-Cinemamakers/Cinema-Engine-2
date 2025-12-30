package backend.utils;

#if !html5
import funkin.data.SongEvent.SongEventData;
import funkin.objects.Strumline.StrumlineData;
import funkin.objects.Strumline.StrumlineInfo;
import funkin.states.PlayState;
import haxe.io.Bytes;
import haxe.zip.Entry;
import haxe.zip.Reader;
import sys.FileSystem;
import sys.io.File;

class CE2FileUtil
{
    public static function unzipCE2SongFile(songDir:String):Array<String> {
        var result:Array<String> = [];
        if(getTempDir() != "") {
            var tempDir:String = getTempDir() + 'ce2/${songDir}/';

            if(FileSystem.exists('${tempDir}${songDir}.json')) {
                var rawJson = File.getContent('${tempDir}${songDir}.json');
                result = [rawJson, tempDir];
                return result;
            }

			var rawFile = File.read('assets/content/songs/${songDir}.ce2');
			var entries: List<Entry> = Reader.readZip(rawFile);
			rawFile.close();
			FileSystem.createDirectory(tempDir);
			
			for(entry in entries) {
				if(entry.compressed){
					entry.data = Reader.unzip(entry);
				}
				var filePath = tempDir + entry.fileName;
				File.saveBytes(filePath, entry.data);
				trace('Extracted ' + entry.fileName + ' to ' + filePath);
			}

			if(FileSystem.exists('${tempDir}${songDir}.json')) trace('${tempDir}${songDir}.json exists');
			var rawJson = File.getContent('${tempDir}${songDir}.json');
            result = [rawJson, tempDir];
            return result;
        }
        return [];
    }

    public static function doesCE2FileExist(filePath:String):Bool {
        if(Paths.exists(filePath)) {
            return true;
        }
        return false;
    }

    public static function getTempDir(): String {
        var envVars = ["TMPDIR", "TEMP", "TMP"];
        for (envVar in envVars) {
            var path = Sys.getEnv(envVar);
            if (path != null && path.length > 0) {
                return path + '/';
            }
        }

        #if windows
        return "C:\\TEMP\\";
        #else
        return "/tmp/";
        #end

        return "";
    }
}
#end