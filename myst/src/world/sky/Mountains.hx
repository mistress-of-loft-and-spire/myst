package statics.sky;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import openfl.display.BitmapData;
import openfl.filters.BitmapFilter;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.events.Event;

/**
 * ...
 * @author VoEC
 */
class Mountains extends Entity
{
	private var sprite = new Image("gfx/tiles/dock_mountains.png");
	
	private var fog:Image = new Image("gfx/sky/sunfog.png");
	private var toggle:Int = 0;
	

	public function new() 
	{
		
		super(0, 0);
		
		//graphic
		
		sprite.y = -36;
		
		//sprite.scale = 0.5;
		sprite.smooth = false;
		
		sprite.scrollX = 0.5;
		sprite.scrollY = 0.9;
		
		fog.scrollX = 0;
		fog.scrollY = 0.1;
		
		addGraphic(sprite);
		addGraphic(fog);
		
		layer = 96;
		
		resize();
			
			HXP.stage.addEventListener(Event.RESIZE, function (e:Event) {
				resize();
			});
	}
	
	override public function update():Void
	{
		
		if (toggle == 1)
		{
			sprite.color = Globals.colormount;
			fog.color = Globals.colorfog;
			super.update();
		}
		toggle = (toggle + 1) % 10;
		
	}
	
	private function resize():Void
	{
		
		fog.x = -HXP.screen.x / HXP.screen.scaleX;
		fog.y = -HXP.screen.y / HXP.screen.scaleY;
		
		fog.scaleX = HXP.stage.stageWidth / 800 / HXP.screen.scaleX;
		fog.scaleY = HXP.stage.stageHeight / 360 / HXP.screen.scaleY;
		
	}

}