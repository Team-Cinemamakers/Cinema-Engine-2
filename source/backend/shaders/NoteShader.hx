package backend.shaders;

import flixel.system.FlxAssets;

class NoteShader extends FlxShader
{
    @:glFragmentSource('
        #pragma header

        uniform vec3 redColor;
        uniform vec3 greenColor;
        uniform vec3 blueColor;

        void main()
        {
            vec4 tex = texture2D(bitmap, openfl_TextureCoordv);

            vec3 remapped =
                tex.r * redColor +
                tex.g * greenColor +
                tex.b * blueColor;

            gl_FragColor = vec4(remapped, tex.a);
        }
    ')
    public function new()
    {
        super();

        redColor.value   = [1.0, 0.0, 0.0];
        greenColor.value = [0.0, 1.0, 0.0];
        blueColor.value  = [0.0, 0.0, 1.0];
    }
}
