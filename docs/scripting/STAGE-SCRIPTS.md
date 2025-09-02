# Variables
## `stage`
Reference to the stage itself

# Functions
## `add(obj:FlxBasic):Void`
Adds an object to the stage.

## `remove(obj:FlxBasic):Void`
Removes an object from the stage.

## `getPositionFromMarker(marker:String):FlxPoint`
Returns an FlxPoint from a stage marker.

# Callbacks
## `create()`
Called when the stage is created, before the stage builder runs.

## `stageBuild()`
Called once the stage builder starts.

## `stageBuildObject(object:StageObject)`
Called once the stage builder starts building an object.

## `stageBuildEnd()`
Called when the stage builder is finished. If you want to add any extra elements to the stage this is probably the best point to do so.