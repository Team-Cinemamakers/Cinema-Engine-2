This is an addendum to the Paths documentation, listing all the folders and what goes into them.

This information may be updated and it may be outdated with the current state of the engine.

```
assets/
    content/ - Main mod content files
        characters/
            character-name/
                character-name.png
                character-name.xml
                character-name.json
                character-name.hxs
        events/
            event-name.json
        game/
            data/
                freeplay.json
        songs/
            song-name/
                song-name.json
                Inst.ogg
                Vocals.ogg
        stages/
            stage-name/
                assets/ - Any assets for this stage should go here
                stage-name.json
                stage-name.hxs
    engine/ - Engine files
        audio/
            music/ - Mostly should be used for all music that isn't related to the songs
            sounds/ - Can be used for any sounds, but preferably ones that aren't related to the songs
        images/
            shared/ - General assets that are used often
            states/ - Assets for specific states
        scripts/
            states/ - Scripts for softcoded states
            substates/ - Scripts for softcoded substates