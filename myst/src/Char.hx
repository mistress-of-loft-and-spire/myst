package;

<<<<<<< HEAD
import com.haxepunk.graphics.atlas.AtlasData;
import openfl.display.BlendMode;
import persp.Camera3D;
import persp.Entity3D;
=======
>>>>>>> 0aaf18acdff926b77c297388f52bb63c0b0cb936
import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.Mask;
<<<<<<< HEAD
import com.haxepunk.math.Vector;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import openfl.geom.Vector3D;
=======
import com.haxepunk.Sfx;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
>>>>>>> 0aaf18acdff926b77c297388f52bb63c0b0cb936
import openfl.geom.Point;

/**
 * ...
 * @author 
 */
<<<<<<< HEAD
class Char extends Entity3D
=======
class Char extends Entity
>>>>>>> 0aaf18acdff926b77c297388f52bb63c0b0cb936
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
<<<<<<< HEAD
	
	private var modylu:Float = 0;
	
	private var ad = AtlasData.getAtlasDataByName("gfx/char.png");
	
	public static var position:Vector3D;

	public function new(x:Float=0, y:Float=0, z:Float=0) 
	{
		
		super(x, y);
		
		shadow.alpha = 0.2;
		
		//addGraphic(shadow);
		addGraphic(sprite);
		
		//addGraphic(dummy_animate); dummy_animate.visible = false;
=======

	public function new(x:Float=0, y:Float=0) 
	{
		
		shadow.alpha = 0.2;
		
		addGraphic(shadow);
		addGraphic(sprite);
		
		addGraphic(dummy_animate); dummy_animate.visible = false;
>>>>>>> 0aaf18acdff926b77c297388f52bb63c0b0cb936
		
		addGraphic(txt);
		txt.size = 8;
		txt.y += 45;
		
<<<<<<< HEAD
		//dummy_animate.add("stand", [0]);
		//dummy_animate.add("walk", [5, 6, 7, 8, 9, 2, 3, 4], 12);
		
		shadow.smooth = sprite.smooth = txt.smooth = false;
		
		sprite.centerOrigin();
		sprite.originY = sprite.height;
		
#if !flash
		ad = AtlasData.getAtlasDataByName("gfx/char.png");
		//ad.blend = AtlasData.BLEND_SCREEN;
#end
		
	}
	
	
	
	override public function update():Void
	{
		
		if (Input.pressed(Key.DIGIT_1)) ad.blend = AtlasData.BLEND_NORMAL;
		if (Input.pressed(Key.DIGIT_2)) ad.blend = AtlasData.BLEND_ADD;
		if (Input.pressed(Key.DIGIT_3)) ad.blend = AtlasData.BLEND_INVERT;
		if (Input.pressed(Key.DIGIT_4)) ad.blend = AtlasData.BLEND_SCREEN;
		if (Input.pressed(Key.DIGIT_5)) ad.blend = AtlasData.BLEND_DARKEN;
		if (Input.pressed(Key.DIGIT_6)) ad.blend = AtlasData.BLEND_OVERLAY;
		if (Input.pressed(Key.DIGIT_7)) ad.blend = AtlasData.BLEND_MULTIPLY;
		if (Input.pressed(Key.DIGIT_8)) ad.blend = AtlasData.BLEND_HARDLIGHT;
		if (Input.pressed(Key.DIGIT_9)) ad.blend = AtlasData.BLEND_SUBTRACT;
		if (Input.pressed(Key.DIGIT_0)) ad.blend = AtlasData.BLEND_DIFFERENCE;
		
		
		
		
		//sprite.blend = BlendMode.SCREEN;
		if (Input.check(Key.SHIFT)) { modylu += 0.01; }
		else { modylu = 1; }
		
		//going left and right -- X
		if (Input.check(Key.A))  { p.x -= 4 * modylu;} //CHANGE THIS TO KONSTANTE
		if (Input.check(Key.D)) { p.x += 4 * modylu; }
		
		//going towards horizon -- Z
		if (Input.check(Key.W))    { p.z += 4 * modylu; }
		if (Input.check(Key.S))  { p.z -= 4 * modylu; }
		
		//jumping up and down -- Y
		if (Input.check(Key.E))    { p.y -= 4 * modylu; }
		if (Input.check(Key.Q))  { p.y += 4 * modylu; }
		
		Camera3D.camera.setTo(HXP.lerp(Camera3D.camera.x, p.x + Camera3D.offset.x, 0.05),
		HXP.lerp(Camera3D.camera.y, p.y + Camera3D.offset.y, 0.05),
		HXP.lerp(Camera3D.camera.z, p.z + Camera3D.offset.z, 0.05));
		
		//size
		
		//sprite.scaleY = (1 * depthFactor) + (horizon_y * depthInverse)
		
		//renderHeight = actualHeight * depthFactor
		
		//sprite.scaleX = ((31 * depthFactor) + (horizon_x * depthInverse)) / 31;
		//sprite.scaleY = ((42 * depthFactor) + (horizon_y * depthInverse)) / 42;
		
		
		//Debug
		txt.text = "X: " + p.x + "\nZ: " + p.z + "\nY: " + p.y + "\nOffset: " + Camera3D.offset;
		
		position = p;
		
		super.update();
		
	}
	
	override public function render():Void
	{
		super.render();
		sprite.scale = gfxScale;
	}
	
	
=======
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
	
>>>>>>> 0aaf18acdff926b77c297388f52bb63c0b0cb936
}