package;

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
class Tree extends Entity3D
{
	
	private var sprite:Image = new Image("gfx/tree.png");	
	

	public function new(x:Float=0, y:Float=0, z:Float=0) 
	{
		
		super(x, y, z);
		
		addGraphic(sprite);
		
		setHitbox(31, 42, 0, 0);
		
		sprite.centerOrigin();
		sprite.originY = sprite.height;
		
		
		type = "tree";
		
		
		
		sprite.smooth = false;
		
		
	}
	
	override public function render():Void
	{
		super.render();
		sprite.scale = gfxScale;
	}
	
	
}