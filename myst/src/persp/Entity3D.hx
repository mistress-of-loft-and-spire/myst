package persp;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Mask;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import openfl.display.BitmapData;
import openfl.geom.Vector3D;

/**
 * ...
 * @author 
 */
class Entity3D extends Entity
{
	
	
	
	private var p:Vector3D = new Vector3D(0, 0, 0);
	
	private var depthFactor:Float = 1; //
	private var depthInverse:Float = 1; //the inverse of your depth factor
	
	private var gfxScale:Float = 1;
	
	
	private var isoFactor:Float = 0;

	public function new(x:Float=0, y:Float=0, z:Float=0) 
	{
		
		super(x, y);
		
		p.setTo(x, y, z);		
		
	}
	
	public function render3D():Void
	{
		
		//deptFactor calc -> dertermines how small + close to the horizon an object gets in the distance
		depthFactor = Camera3D.nearClipZ / (Camera3D.nearClipZ + (p.z - Camera3D.camera.z));
		
		
		//smoothing when switch to isometric or perspective render
		if (Camera3D.isometric)
		{
			if(isoFactor < 1) isoFactor += 0.01;
		}
		else
		{
			if(isoFactor > 0) isoFactor -= 0.01;
		}
		if (Camera3D.isometric || isoFactor > 0) { depthFactor = HXP.lerp(depthFactor,1,isoFactor); }
		
		
		depthInverse = 1.0 - depthFactor; 
		
		//pos
		y = ((p.y - Camera3D.camera.y) * depthFactor) + (Camera3D.horizon_y * depthInverse);
		x = ((p.x - Camera3D.camera.x) * depthFactor) + (Camera3D.horizon_x * depthInverse);
		
		//isometric pos (no horizon / infinite horizon?)
		if (Camera3D.isometric || isoFactor > 0) { y -= HXP.lerp(0, p.z - Camera3D.camera.z, isoFactor); }
		
		//scale
		gfxScale = depthFactor;
		
	}
	
	override public function update():Void
	{
		
		//set layer based on z distance
		layer = Math.round(p.z);
		
		//near clipping z -> hide entity when behind camera view
		if ((p.z - Camera3D.camera.z) < -Camera3D.nearClipZ)
		{ visible = false; }
		else if ((p.z - Camera3D.camera.z) < -Camera3D.nearClipZ-20)
		{ visible = false; render3D(); }
		else
		{ visible = true; }
		
		super.update();
		
	}
	
	override public function render():Void
	{
		
		super.render();
		
		render3D();
		
	}
	
}