package source.backend;

import flixel.FlxGame;

class CinemaGame extends flixel.FlxGame
{
    public override function switchState(){
        super.switchState();
        draw();
    }
}