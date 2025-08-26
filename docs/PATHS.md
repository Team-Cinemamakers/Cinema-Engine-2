# Structure
Cinema Engine 2 follows a file structure similar, but also very different to the traditional engine.

The assets are split into **ENGINE** and **CONTENT** assets.

## Engine
Engine assets are assets concerning just the engine part. State assets, UI elements, menu sounds - They are here. The assets are contained in the `engine` folder.

## Content
Content assets are the assets of your mod. Characters, songs, events - Those are content assets. The assets are contained in the `content` folder.

# Using paths
CE2 features a `Paths` class similar to one you may find in most engines.

## Utility functions
### `exists(path:String)`
Returns `true` or `false` depending on if a file exists at a certain path.

The path inputted must be a full path (including the extension) to the file starting from the `assets` folder. (e.g. `Paths.exists("assets/engine/audio/sounds/scrollMenu.ogg)`)

## File functions
### `file(path:String, directory:String, source:PathSource)`
The generic file function. If there is a file at the end path then it returns that.

Arguments explained individually:

`path` - Mostly used to specify the concrete file name  (e.g. `logoBumpin.png`) <br>
`directory` - Used to specify the folder the file is in, starting from the source (explained below) (e.g. `images/states/titleState`) <br>
`source` - Specifies whether the engine should look in the `engine` (`PathSource.ENGINE`) or `content` (`PathSource.CONTENT`) folders. There is also the choice of no source, in which case you must specify the full path starting from the `assets` folder (`PathSource.OTHER`) (e.g. `PathSource.ENGINE`). By default the source is set to `CONTENT`.

Full line would look like this - `Paths.file('logoBumpin.png', 'images/states/titleState', PathSource.ENGINE)`

Apart from the generic file function, there are several functions specialized at returning a specific type of assets:
- `image` - Returns .png files
- `audio` - Returns .ogg files
- `json` - Returns .json files
- `xml` - Returns .xml files

Note - You don't need to specify the extension when using these functions. It will be filled out automatically.

### `sparrow(path:String, directory:String, source:PathSource)`
Returns a sparrow atlas for use with FlxSprites.

Sparrow atlases are used for most animated sprites in the game. They include a `png` spritesheet, alongside an `xml` file that includes animations. As such, the two must be located in the same folder and named the same name to be properly detected.

Example - `Paths.sparrow('bf', 'characters/bf')` will return frames of the boyfriend spritesheet.

### `bitmap(path:String, directory:String, source:PathSource)`
Returns an image as a bitmap. This function is mostly used by the `sparrow` function, as FlxAnimate requires bitmap data of the sprites.