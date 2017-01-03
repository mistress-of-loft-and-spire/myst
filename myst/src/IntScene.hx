import com.haxepunk.HXP;
import com.haxepunk.Scene;
import persp.Camera3D;
import persp.Ground3D;
import world.Horizon;
import world.Wind;
import world.objects.HutInterior;
import world.objects.HutLight;
import world.objects.HutObject;

class IntScene extends Scene
{

	override public function begin()
	{
		
		HXP.screen.color = 0x121c1b;
		
		
		add(new Camera3D(0, -50, 400));
		//vector3d: -396, -236, 360
		
		add(new Char());
		
		for (i in 0...18)
		{
			add(new HutInterior(0, 0, 0, i));
		}
		
		for (i in 0...3)
		{
			add(new HutObject(-42, 2, 24, i, "tvset"));
		}
		
		for (i in 0...2)
		{
			add(new HutObject(-10, 2, 28, i, "stool"));
		}
		
		add(new HutLight(11, 15, 24));
		
	}

}