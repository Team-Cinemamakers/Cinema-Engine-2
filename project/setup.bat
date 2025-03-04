@echo off
color 6
FOR /F "tokens=*" %%g IN ('haxe --version') do (SET haxeVer=%%g)
echo Haxe version - %haxeVer% (Supported version: 4.3.6)

echo Installing Libraries!

haxelib install flixel
haxelib install flixel-addons
haxelib install hxcpp

echo Done!
color 7