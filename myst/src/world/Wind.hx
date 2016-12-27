package world;

import com.haxepunk.Tween.TweenType;
import com.haxepunk.tweens.misc.Alarm;
import persp.Camera3D;
import persp.Entity3D;
import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import openfl.geom.Vector3D;
import openfl.geom.Point;

/**
 * ...
 * @author 
 */
class Wind extends Entity3D
{
	
	private var sprite:Image = new Image("gfx/wind.png");
	
	private var direction:Vector3D = new Vector3D();
	
	private var sy:Float = 1;
	
	private var sin:Float = 0;
	private var base:Float = 0;

	public function new(x:Float=0, y:Float=-80, z:Float=0) 
	{
		
		super(x, y, z);
		
		base = y;
		
		addGraphic(sprite);
		
		sprite.centerOrigin();
		sprite.originY = sprite.height;
		
		sprite.smooth = false;
		
		//sprite.alpha = 0.7;
		
		
		HXP.alarm(4, resetWind, TweenType.Looping);
		
	}
	
	
	
	override public function update():Void
	{
		
		super.update();
		
		sin += 0.1;
		p.y = base - (Math.sin(sin)*3);
		
		p.x += direction.x;
		p.z += direction.z;
		
	}
	
	override public function render():Void
	{
		super.render();
		sprite.scale = gfxScale;
	}
	
	private function resetWind(e:Dynamic = null):Void
	{
		p.x = Char.position.x;
		p.z = Char.position.z;
		p.y = -80;
		
		direction.setTo((Math.random() * 2) - 1, 0, (Math.random() * 2) - 1);
		
		sprite.angle = -HXP.angle(0, 0, direction.x, direction.z) + 45;
		
		var normal:Vector3D = direction;
		normal.normalize();
		
		sy = 1 - Math.abs(normal.z);
		
		//trace(direction);
		
		//trace(((Camera3D.camera.y) * depthFactor) + (Camera3D.horizon_y * depthInverse));
		
	}
	
	
}