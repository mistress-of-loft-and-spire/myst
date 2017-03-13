package statics.sky;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Mask;
import com.haxepunk.Tween;
import com.haxepunk.tweens.misc.Alarm;
import openfl.display.BitmapData;
import openfl.geom.Point;

/**
 * ...
 * @author ...
 */
class Sternschn_Emitter extends Entity
{
	
	private var direction:Int;

	private var speed:Float = 0.05;
	
	private var alarm:Alarm;
	
	public function new() 
	{
		
		super();
		
		graphic = new Image(new BitmapData(1, 1, true, 0x11FFFFFF));
		
		
		y = HXP.rand(100);
		
		direction = HXP.rand(180) + 180;
		
		if (direction > 270)
		{
			x = HXP.rand(50) + 50;
		}
		else
		{
			x = HXP.screen.width - HXP.rand(50);
		}
		
		layer = 97;
		
		graphic.scrollX = graphic.scrollY = 0;
		
		addTween(alarm = new Alarm((Math.random() * 2) + 0.3, sternschnuppe, TweenType.Persist), true);
		
		HXP.alarm((Math.random() * 20) + 45, end, TweenType.OneShot);
		
	}
	
	private function sternschnuppe(e:Dynamic = null)
	{
		
		world.create(Sternschnuppe).init(new Point(x, y));
		
		alarm.reset((Math.random() * 2) + 0.3);
		
	}
	
	private function end(e:Dynamic = null)
	{
		
		alarm.cancel();
		world.remove(this);
		
	}
	
	override public function update():Void
	{
		y += Math.sin(HXP.RAD * direction) * speed;
		x += Math.cos(HXP.RAD * direction) * speed;
		
		super.update();
	}
	
}