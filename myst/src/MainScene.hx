import com.haxepunk.HXP;
import com.haxepunk.Scene;
import persp.Camera3D;
import persp.Ground3D;
import world.Fog;
import world.Horizon;
import world.Water;
import world.Wind;
import world.Island;
import world.sky.Sun;

class MainScene extends Scene
{

	override public function begin()
	{
		
		HXP.screen.color = 0xc0d0de;
		
		
		add(new Camera3D(0, -50, 400));
		add(new Horizon());
		
		add(new Char());
		
		//add(new Wind());
		
		for (i in 0...100)
		{
			add(new Island((Math.sin(i*0.1)*3), 0, 0, i));
			add(new Water(-42+(Math.sin(i*0.1)*3), 0, -0.1, i, i*0.02));
		}
		
		/*  FOG
		for (i in 0...6)
		{
			add(new Fog(i*40));
		}
		*/
		
		/*
		-b.n.---,.-.-,--.,.-.-m,,-.,.-,-m,-,m.,,mlöj,m-,m.m-m,-,ömö,ö,ö--..-.ä.ü.ä.
		
		
		
		
		
		.,.+-+´#+.-+#.-´.#+.-´+#.-.-´+#-.#-,´.#+-,´.´-´+,.´-#+.-#+.+#-,.-´#´m#-´.,
		*/
		
		add(new Sun());
		
		add(new Tree(0, 0, 0));
		add(new Tree(0, 0, 1000));
		add(new Tree(1000, 0, 1000));
		add(new Tree(1000, 0, 0));
		
		//add(new Ground3D(0, 0, 1000, [0, 0, 0, 100, 100, 100, 100, 0]));
		
		/*
		for (i in 0...50)
		{
			add(new Tree(Math.random() * 1000, 0, Math.random() * 1000));
		}*/
		
	}

}