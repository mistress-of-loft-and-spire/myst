package statics.sky;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
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
class Moon extends Entity
{
	private var sprite = new Spritemap("gfx/sky/moon.png", 180, 180);
	
	private var moonback:Image;
	private var moonb:Entity;
	
	private var toggle:Int = 0;
	
	private var frame:Int;
	

	public function new() 
	{
		
		super();
		
		moonback = Image.createCircle(51, 0x363545);
		
		sprite.scale = moonback.scale = 0.5;
		sprite.smooth = moonback.smooth = true;
		
		//addGraphic(spriteback);
		addGraphic(sprite);
		
		sprite.centerOrigin();
		moonback.centerOrigin();
		
		sprite.frame = 1;
		
		graphic.scrollX = 0;
		graphic.scrollY = 0;
		
		moonback.scrollX = moonback.scrollY = 0;
		moonback.angle += 0.1;
		
		//stars.
		
		//var bito:BitmapData = new BitmapData(stars.width, stars.height);
		
		//bito.copyChannel(HXP.getBitmap("gfx/sun.png"), new Rectangle(0, 0, 450, 450), new Point(1000, 1000), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
		
		//stars.drawMask = bito;

		layer = 97;
	}
	
	override public function added():Void
	{
		
		world.addGraphic(moonback, 99, 0, 0);
		
		frame = (Math.round(Globals.moonphase / 50)) % 16;
		
		if (frame > 8)
		{
			frame = 16 - frame;
			sprite.scaleX = sprite.scaleY = -1;
		}
		else
		{
			sprite.scaleX = sprite.scaleY = 1;
		}
		
		sprite.frame = frame;
	}
	
	override public function update():Void
	{
		
		//Hide if sky is cloudy
		if (Globals.wetter == 3) { visible = false; moonback.visible = false; }
		
		//Color adjust
		if (toggle == 1)
		{
			sprite.color = Globals.colormoon;
			super.update();
		}
		toggle = (toggle + 1) % 10;
		
		
		//Calculating lunar phase
		
		//Increate time (loop when MAX_TIME is hit)
		Globals.moonphase = (Globals.moonphase + (0.15 / Globals.tweentime)) % 800;
		
		if (y > 450 || Globals.tweentime < 5) //nur updaten wenn unterm horizont
		{
			
			frame = (Math.round(Globals.moonphase / 50)) % 16;
			
			if (frame > 8)
			{
				frame = 16 - frame;
				sprite.scaleX = sprite.scaleY = -1;
			}
			else
			{
				sprite.scaleX = sprite.scaleY = 1;
			}
			
			sprite.frame = frame;
			
		}
		
		//Calculating position
		
		var radians:Float = sprite.angle = (Globals.time / 4) + 180 - (Globals.moonphase * 0.45);
		sprite.angle += 20;
		moonback.angle = sprite.angle;
		radians *= HXP.RAD;
		moonback.x = x = 400 + Math.sin(radians) * 212;
		moonback.y = y = 250 - Math.cos(radians) * 212;
		
		
	}
	

}