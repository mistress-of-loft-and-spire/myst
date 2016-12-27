<<<<<<< HEAD
import com.haxepunk.graphics.Image;
=======
>>>>>>> 0aaf18acdff926b77c297388f52bb63c0b0cb936
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import persp.Camera3D;
import persp.Ground3D;
import world.Horizon;
import world.Wind;

class MainScene extends Scene
{

	override public function begin()
	{
		
		HXP.screen.color = 0xc0d0de;
		
		
		add(new Camera3D());
		add(new Horizon());
		
		add(new Char());
		
		add(new Wind());
		
		
		add(new Tree(0, 0, 0));
		add(new Tree(0, 0, 1000));
		add(new Tree(1000, 0, 1000));
		add(new Tree(1000, 0, 0));
		
		add(new Ground3D(0, 0, 1000, [0, 0, 0, 100, 100, 100, 100, 0]));
		
		/*
		for (i in 0...50)
		{
			add(new Tree(Math.random() * 1000, 0, Math.random() * 1000));
		}
		*/
	}

}