package world;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Mask;
import openfl.display.BitmapData;
import persp.Camera3D;

/**
 * ...
 * @author 
 */
class Fog extends Entity
{
	
	private var fogBitmap:BitmapData;
	
	private var zLayer:Int = 0;
	var fogImage:Image;

	public function new(fogLayer:Int = 0) 
	{
		
		super();
		
		fogBitmap = new BitmapData(1, 1, false, 0xFF96a9b9);
		fogImage = new Image(fogBitmap);
		
		addGraphic(fogImage);
		
		fogImage.alpha = 0.2;
		
		zLayer = fogLayer - 200;
		
	}
	
	override public function update():Void
	{
		
		fogImage.scaleX = HXP.width;
		fogImage.scaleY = HXP.height;
		
		layer = Math.round(Camera3D.camera.z) + zLayer;
		
		fogImage.y = Camera3D.horizon_y;
		
		super.update();
		
	}
	
}