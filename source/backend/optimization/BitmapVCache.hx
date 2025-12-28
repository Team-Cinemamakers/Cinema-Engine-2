package backend.optimization;

import lime.graphics.Image;
import lime.graphics.cairo.CairoImageSurface as Cairo;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

//simple VCache system i figured out by looking at like 7 different engines and a bunch of libraries and wanting to shoot myself
class BitmapVCache extends BitmapData {
    /**simply put, if vcache is on, when adding sprite from image, we add it directly to the context3d, which is uesed for rendering geometrically defined graphics (thus the rect :3)
    * stage.context3D holds textures which purely are rendered and held in VRAM
    * we lock the sprite so it does not update objects which reference the bitmap after this change is made, otherwise we would get uh-oh stuff
    * we then get the texture from the context3d or whatever dude im tired
    * also set that shit to valid thank you much
    */
	public override function __fromImage(image:Image):Void
	{
        trace('loading vcached image');
		if (image != null && image.buffer != null)
		{
            this.image = image;

            readable = true;
            __isValid = true;
			   
			width = image.width;
			height = image.height;
            __textureWidth = width;
			__textureHeight = height;
			rect = new Rectangle(0, 0, image.width, image.height);

			#if sys
			image.format = BGRA32;
			image.premultiplied = true;
			#end
			
			if(FlxG.stage.context3D != null) {
				lock();
				getTexture(FlxG.stage.context3D);
				this.image = null;
			}
		}
	}
}