package;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.Mask;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import openfl.geom.Point;

/**
 * ...
 * @author 
 */
class Char extends Entity
{
	
	private var sprite:Spritemap = new Spritemap("gfx/char.png", 31, 42);
	private var shadow:Image = new Image("gfx/char-shadow.png");
	
	private var dummy_animate:Spritemap = new Spritemap("gfx/char.png", 31, 42);
	
	private var step_sand:Sfx = new Sfx("sfx/OOT_Steps_Sand1.wav");
	
	private var txt:Text = new Text();
	
	private var movement:Point = new Point(0, 0);
	private var speed:Float = 0;
	private var direction:Float = 0;
	
	private var walker:Int = 2;
	private var walk_timer:Float = 0;

	public function new(x:Float=0, y:Float=0) 
	{
		
		shadow.alpha = 0.2;
		
		addGraphic(shadow);
		addGraphic(sprite);
		
		addGraphic(dummy_animate); dummy_animate.visible = false;
		
		addGraphic(txt);
		txt.size = 8;
		txt.y += 45;
		
		dummy_animate.add("stand", [0]);
		dummy_animate.add("walk", [5, 6, 7, 8, 9, 2, 3, 4], 12);
		
		shadow.smooth = sprite.smooth = txt.smooth = false;
		
		graphic.x = -16; graphic.y = -39;
		
		super(x, y);
		
	}
	
	override public function update():Void
	{
		
		movement.x *= 0.88; movement.y *= 0.88;
		
		if (Input.check(Key.LEFT))  { movement.x -= 0.25; } //KONSTANTE
		if (Input.check(Key.RIGHT)) { movement.x += 0.25; }
		
		if (Input.check(Key.UP))    { movement.y -= 0.25; }
		if (Input.check(Key.DOWN))  { movement.y += 0.25; }
		
		//Zero Cutoff Margin
		if (Math.abs(movement.x) < 0.1) movement.x = 0;
		if (Math.abs(movement.y) < 0.1) movement.y = 0;
		
		if (movement.length > 0)
		{
			direction = HXP.angle(0, 0, movement.x, movement.y);
			
			moveAtAngle(direction, HXP.clamp(movement.length, -2, 2));
		}
		
		walk(sprite);
		
		
		//Debug
		txt.text = "Angle: " + direction + "\nFrame: " + sprite.frame + "\nmovementlength: " + HXP.clamp(movement.length, -2, 2);
		
		super.update();
		
	}
	
	function walk(sprite:Spritemap) 
	{
		
		//Animation
		sprite.frame = Math.round(direction / 360 * 8);
		
		if (sprite.frame > 7) sprite.frame -= 8;
		if (sprite.frame < 0) sprite.frame += 8; //mod!!!
		
		if (movement.length > 0.2)
		{
			dummy_animate.play("walk");
		}
		else
		{
			dummy_animate.play("stand");
		}
		
		dummy_animate.rate = HXP.clamp(movement.length, -2, 2) / 1.8;
		
		sprite.frame += dummy_animate.frame * 8;
		
		if (dummy_animate.frame == 2 || dummy_animate.frame == 6)
		{
			walk_sound();
		}
		
	}
	
	function walk_sound(param:String = "NULL") 
	{
		//Sound
		if (!step_sand.playing) step_sand.play();
		
		step_sand.volume = (movement.length / 4) + 0.4;
	}
	
}