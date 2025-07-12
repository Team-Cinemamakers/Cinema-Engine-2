@echo off

SET preferredHaxeVersion=4.3.7
FOR /F "tokens=*" %%g IN ('haxe --version') do (SET haxeVer=%%g)

color 6

echo Engine Haxe version - %preferredHaxeVersion%
echo Installed Haxe version - %haxeVer%
if %haxeVer% == %preferredHaxeVersion% (
    echo Installing Libraries!

    haxelib install flixel
    haxelib install flixel-addons
    haxelib install hxcpp
    haxelib install openfl
    haxelib git flxanimate https://github.com/Dot-Stuff/flxanimate

    echo Done!
) else (
    color c
    echo You have an incorrect Haxe version. Please install Haxe %preferredHaxeVersion%
)
