package persp;

import com.haxepunk.graphics.atlas.Atlas;
import com.haxepunk.masks.Polygon;
import com.haxepunk.RenderMode;
import openfl.display.BitmapData;
import openfl.display.Graphics;
import openfl.display.JointStyle;
import openfl.display.LineScaleMode;
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
class Ground3D extends Entity
{
	
	private var sprite:Image;
	
	private var poly:Polygon;
	
	private var points:Array<Float>;
	
	
	
	
	private var pup:Vector3D = new Vector3D(0, 0, 0);
	
	
	
	private var depthFactor:Float = 1; //
	private var depthInverse:Float = 1; //the inverse of your depth factor
	
	private var gfxScale:Float = 1;
	
	
	private var isoFactor:Float = 0;
	
	
	private var txt:Text = new Text();
	

	public function new(x:Float=0, y:Float=0, z:Float=0, tpoints:Array<Float>) 
	{
		
		super(0, 0);
		
		pup.setTo(x, y, z);
		
		points = tpoints;
		
		//var test:Vector = new Vector(0, 100);
		
		poly = Polygon.createFromArray([0,0,0,10,10,10,10,0]);
		
		sprite = Image.createPolygon(poly, 0xff9988);
		
		addGraphic(sprite);
		
		
		sprite.smooth = false;
		
		
		addGraphic(txt);
		txt.size = 16;
		txt.y -= 45;
		
		
	}
	
	public function render3D():Void
	{
		
		//deptFactor calc -> dertermines how small + close to the horizon an object gets in the distance
		//depthFactor = Camera3D.nearClipZ / (Camera3D.nearClipZ + (p.z - Camera3D.camera.z));
		
		
		
		
		//depthInverse = 1.0 - depthFactor; 
		
		//pos
		//y = ((p.y - Camera3D.camera.y) * depthFactor) + (Camera3D.horizon_y * depthInverse);
		//x = ((p.x - Camera3D.camera.x) * depthFactor) + (Camera3D.horizon_x * depthInverse);
		
		//isometric pos (no horizon / infinite horizon?)
		//if (Camera3D.isometric || isoFactor > 0) { y -= HXP.lerp(0, p.z - Camera3D.camera.z, isoFactor); }
		
		//scale
		//gfxScale = depthFactor;
		
		var arra:Array<Float> = new Array<Float>();
		
		var base:Array<Vector> = [new Vector(0, 0), new Vector(1000, 0), new Vector(1000, 1000), new Vector(0, 1000)];
		
		//for each point
		for (i in 0...base.length)
		{
			
			var p_depthFactor:Float = Camera3D.nearClipZ / (Camera3D.nearClipZ + (base[i].y - Camera3D.camera.z));
			if (i == 2)
			{
				trace(p_depthFactor);
				p_depthFactor = HXP.clamp(p_depthFactor,0,0.5);
			}
			
			
			var p_depthInverse:Float = 1.0 - p_depthFactor; 
			
			arra.push(Std.int(((base[i].x - Camera3D.camera.x) * p_depthFactor) + (Camera3D.horizon_x * p_depthInverse)));
			arra.push(Std.int(((0 - Camera3D.camera.y) * p_depthFactor) + (Camera3D.horizon_y * p_depthInverse)));
			
			
			
		}
		

		
		poly = Polygon.createFromArray(arra);
		
		sprite = createGround(poly, 0xff9988);
		
		graphic = sprite;
		
		addGraphic(txt);
		
	}
	
	override public function update():Void
	{
		
		//set layer based on z distance
		layer = Math.round(pup.z);
		/*il
		//near clipping z -> hide entity when behind camera view
		if ((p.z - Camera3D.camera.z) < -Camera3D.nearClipZ)
		{ visible = false; }
		else if ((p.z - Camera3D.camera.z) < -Camera3D.nearClipZ-20)
		{ visible = false; render3D(); }
		else
		{ visible = true; }*/
		
		super.update();
		
	}
	
	override public function render():Void
	{
		
		render3D();
		super.render();
	}
	
	public static function createGround(polygon:Polygon, color:Int = 0xFFFFFF, alpha:Float = 1, fill:Bool = true, thick:Int = 1):Image
	{
		var graphics:Graphics = HXP.sprite.graphics;
		var points:Array<Vector> = polygon.points;

		var minX:Float;
		var maxX:Float;
		var minY:Float;
		var maxY:Float;

		var p:Point;
		var originalAngle:Float = polygon.angle;

		polygon.angle = 0;	// set temporarily angle to 0 so we can sync with image angle later

		minX = minY = 600;
		maxX = maxY = -600;

		// find polygon bounds
		for (p in points)
		{
			if (p.x < minX) minX = p.x;
			if (p.x > maxX) maxX = p.x;
			if (p.y < minY) minY = p.y;
			if (p.y > maxY) maxY = p.y;
		}

		var w:Int = 600;
		var h:Int = 600;

		if (color > 0xFFFFFF) color = 0xFFFFFF & color;
		graphics.clear();

		if (fill)
			graphics.beginFill(0xFFFFFF);
		else
			graphics.lineStyle(thick, 0xFFFFFF, 1, false, LineScaleMode.NORMAL, null, JointStyle.MITER);
		
		
		graphics.moveTo(points[points.length - 1].x, points[points.length - 1].y);
		for (p in points)
		{
			graphics.lineTo(p.x, p.y);
		}
		graphics.endFill();

		//HXP.matrix.identity();
		//HXP.matrix.translate( -minX, -minY);

		var data:BitmapData = HXP.createBitmap(w, h, true, 0);
		data.draw(HXP.sprite, HXP.matrix);

		var image:Image;
		if (HXP.renderMode == RenderMode.HARDWARE)
		{
			image = new Image(Atlas.loadImageAsRegion(data));
		}
		else
		{
			image = new Image(data);
		}

		// adjust position, origin and angle
		//image.x = polygon.x + polygon.origin.x;
		//image.y = polygon.y + polygon.origin.y;
		//image.originX = image.x - polygon.minX;
		//image.originY = image.y - polygon.minY;
		//image.angle = originalAngle;
		//polygon.angle = originalAngle;

        image.color = color;
        //image.alpha = alpha;

		return image;
	}
	
	
}