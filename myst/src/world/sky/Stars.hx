package statics.sky;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Tween;
import com.haxepunk.tweens.misc.Alarm;
import com.haxepunk.utils.Draw;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.BitmapDataChannel;
import openfl.events.Event;
import openfl.geom.Rectangle;
import openfl.geom.Point;

/**
 * ...
 * @author ...
 */
class Stars extends Entity
{
	
	private var stars:Image = new Image("gfx/sky/stars.png");
	private var back:Image = new Image("gfx/sky/back_night2.png");
	
	public function new() 
	{
		super(0, 0);
			
		back.x = -HXP.screen.x / HXP.screen.scaleX;
		
		layer = 99;
		
		addGraphic(back);
		addGraphic(stars);
		
		
		stars.smooth = false;
		back.smooth = false;
		
		stars.centerOrigin();
		
		stars.x = 400; stars.y = 250;
		
		graphic.scrollX = graphic.scrollY = 0;
		
		HXP.stage.addEventListener(Event.RESIZE, function (e:Event) {
				resize();
		});
		
		HXP.alarm(HXP.rand(50)+50, sternschnuppe, TweenType.OneShot);
		
	}
	
	override public function update():Void
	{
		
		stars.angle = (Globals.time / 4) + 180;
		
		if (Globals.wetter == 3) stars.visible = false;
		
		super.update();
		
	}
	
	private function sternschnuppe(e:Dynamic=null)
	{
		if(Globals.wetter == 0)
		{
			
			if (Math.random() > 0.1)
			{
				world.create(Sternschnuppe).init(new Point(HXP.rand(HXP.screen.width), HXP.rand(100)));
			}
			else
			{
				world.add(new Sternschn_Emitter());
			}
			
		}
		
		HXP.alarm(HXP.rand(100)+100, sternschnuppe, TweenType.OneShot);
		
	}
	
	private function resize():Void
	{
		
		back.x = -HXP.screen.x / HXP.screen.scaleX;
		back.y = -HXP.screen.y / HXP.screen.scaleY;
		
		back.scaleX = HXP.stage.stageWidth / 800 / HXP.screen.scaleX;
		back.scaleY = HXP.stage.stageHeight / 360 / HXP.screen.scaleY;
		
	}
	
}