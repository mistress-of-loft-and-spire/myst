import com.haxepunk.HXP;
import com.haxepunk.Scene;

class MainScene extends Scene
{

	override public function begin()
	{
		
		HXP.screen.color = 0x938d81;
		
		add(new Char(200, 200));
		
	}

}