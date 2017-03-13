package statics.sky;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.tweens.misc.VarTween;
import com.haxepunk.utils.Ease;
import openfl.geom.Point;
import com.haxepunk.Tween;

/**
 * ...
 * @author ...
 */
class Sternschnuppe extends Entity
{
	
	private var speed:Float = 4;
	
	private var img:Image = new Image("gfx/sky/sternschnuppe.png");

	public function new() 
	{
		
		
		layer = 97;
		
		addGraphic(img);
		
		
		img.smooth = false;
		
		graphic.scrollX = graphic.scrollY = 0;
		
		
		super();
		
	}
	
	public function init(origin:Point):Void
	{
		
		img.angle = HXP.rand(220)+160; //direction meteor is flying
		
		layer = 97;
		
		x = origin.x;
		y = origin.y;
		
		var max_alpha:Float = (Math.random() * 0.5);
		
		var tween_in:VarTween = new VarTween(tween_done, TweenType.OneShot);
		tween_in.tween(img, "alpha", max_alpha, 0.4); //object, property:String, to:Number, duration, ease = null
		addTween(tween_in, true);
		
	}
	
	private function tween_done(e:Dynamic=null)
	{
		
		var tweenout:VarTween = new VarTween(all_done, TweenType.OneShot);
		tweenout.tween(img, "alpha", 0, 0.4);
		addTween(tweenout, true);
		
	}
	
	private function all_done(e:Dynamic=null)
	{
		
		world.recycle(this);
		
	}
	
	override public function update():Void
	{
		
		y += Math.sin(HXP.RAD * img.angle) * speed;
		x += Math.cos(HXP.RAD * img.angle) * speed;
		
		super.update();
	}
	
}