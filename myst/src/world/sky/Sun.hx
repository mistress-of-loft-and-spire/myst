package world.sky;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Mask;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import openfl.filters.BitmapFilter;
import persp.Camera3D;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.events.Event;
import openfl.geom.Rectangle;
import openfl.geom.Point;


class Sun extends Entity 
{
	
	private var sprite:Image = new Image("gfx/sun.png");
	
	private static var MAX_TIME:Int = 1440;
	
	private var time:Float = 0;
	private var timeStep:Int = 200;
	
	public static var color1:Int = 0x000000;
	public static var colorfog:Int = 0x000000;
	public static var colorwater:Int = 0x000000;
	
	//								  ([  night,    dawn,     day,      day,      day,      dusk,     night,    night ])
	private static var COLORS1       = [0x23202b, 0x494d63, 0x434d52, 0x434d52, 0x434d52, 0x2f3647, 0x23202b, 0x23202b];
	private static var COLORSFOG     = [0x474458, 0xe1b9b9, 0xdcdfe6, 0xdcdfe6, 0xdcdfe6, 0xd49e9b, 0x474458, 0x474458];
	private static var COLORSMOUNT   = [0x444154, 0x9494a8, 0xcacdd4, 0xcacdd4, 0xcacdd4, 0x635570, 0x444154, 0x444154];
	//private static var COLORSWATER   = [0x575468, 0x8a8aa6, 0xa9b6bd, 0xa9b6bd, 0xa9b6bd, 0x827490, 0x575468, 0x575468];
	private static var COLORSWATER   = [0x575468, 0x8a8aa6, 0x96a9b9, 0x96a9b9, 0x96a9b9, 0x827490, 0x575468, 0x575468];
	
	private static var COLORSMOON    = [0xdfdfe8, 0xe9d7e0, 0xe6e8f2, 0xe6e8f2, 0xe6e8f2, 0xd0bfce, 0xdfdfe8, 0xdfdfe8];
	private static var COLORSOVERLAY = [0x737299, 0xc2c2fe, 0xffffff, 0xffffff, 0xffffff, 0xd2afef, 0x737299, 0x737299];
	private static var COLORSTITLE   = [0xffffff, 0xf5b9bf, 0x60646b, 0x60646b, 0x60646b, 0xc4c5ee, 0xffffff, 0xffffff];

	private var overlayLast:Int = 0;
	public var overlayCurrent:Int = 2;
	
	public function new()
	{
		super(0, 0);
		
		
		//var bito:BitmapData = new BitmapData(450,450,true,0xFFFFFFFF);
		//var thesun:BitmapData = new BitmapData(450, 450, true, 0xFF000000);
		
		//thesun.copyPixels(HXP.getBitmap("gfx/sky/sun.png"), new Rectangle(0, 0, 450, 450), new Point(0, 0), HXP.getBitmap("gfx/sky/sun.png"), new Point(150, 0), false);
		//bito.copyChannel(HXP.getBitmap("gfx/sun.png"), new Rectangle(0, 0, 450, 450), new Point(150, 0), 8, 8))
		
		
		
		addGraphic(sprite);
		
		sprite.centerOrigin();
			
		var radians:Float = HXP.RAD*((time / 4) + 180);
		x = 400 + Math.sin(radians) * 212;
		y = 250 - Math.cos(radians) * 212;
		
		layer = Math.round(Camera3D.farClipZ) + 10;
		
		sprite.smooth = false;
		
		sprite.scale = 0.5;
		sprite.angle += 0.1;
	}

	override public function update():Void
	{
		
			
		//Hide if sky is cloudy
		//if (Globals.wetter == 3) visible = false;
		
		
		//Increate time (loop when MAX_TIME is hit)
		time = (time + (8 / timeStep)) % MAX_TIME;
		
		//Find the two colors two blend between
		var index:Float = HXP.scale(time, 0, MAX_TIME, 0, COLORS1.length);
		if (overlayCurrent != Std.int(index))
		{
			overlayLast = overlayCurrent;
			overlayCurrent = Std.int(index);
		}
		
		color1 = HXP.colorLerp(COLORS1[overlayLast], COLORS1[overlayCurrent], index % 1);
		colorfog = HXP.colorLerp(COLORSFOG[overlayLast], COLORSFOG[overlayCurrent], index % 1);
		colorwater = HXP.colorLerp(COLORSWATER[overlayLast], COLORSWATER[overlayCurrent], index % 1);
		
		
		HXP.screen.color = colorfog;
		
		//Set the overlay color to a blend between the previous and current color
		/*
		Globals.colorfog = HXP.colorLerp(COLORSFOG[overlayLast], COLORSFOG[overlayCurrent], index % 1);
		Globals.colormount = HXP.colorLerp(COLORSMOUNT[overlayLast], COLORSMOUNT[overlayCurrent], index % 1);
		Globals.colorwater = HXP.colorLerp(COLORSWATER[overlayLast], COLORSWATER[overlayCurrent], index % 1);
		Globals.colormoon = HXP.colorLerp(COLORSMOON[overlayLast], COLORSMOON[overlayCurrent], index % 1);
		Globals.coloroverlay = HXP.colorLerp(COLORSOVERLAY[overlayLast], COLORSOVERLAY[overlayCurrent], index % 1);
		Globals.colortitle = HXP.colorLerp(COLORSTITLE[overlayLast], COLORSTITLE[overlayCurrent], index % 1);
		*/
		var radians:Float = HXP.RAD*((time / 4) + 180);
		x = HXP.halfWidth + Math.sin(radians) * 180;
		y = Camera3D.horizon_y - Math.cos(radians) * 180;
		
		
		if (Input.check(Key.T)) timeStep = 10;
		else timeStep = 200;
		
		
		super.update();
		
		
		
		
	}
	
}