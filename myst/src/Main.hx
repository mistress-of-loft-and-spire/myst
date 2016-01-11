import com.haxepunk.Engine;
import com.haxepunk.HXP;

class Main extends Engine
{

	override public function init()
	{
#if debug
		HXP.console.enable();
#end
		
		HXP.screen.color = 0x353d41;
		
		HXP.scene = new MainScene();
	}

	public static function main() { new Main(); }

}