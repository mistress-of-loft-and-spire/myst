import com.haxepunk.Engine;
import com.haxepunk.HXP;

class Main extends Engine
{

	override public function init()
	{
#if debug
		//HXP.console.enable();
#end
		
		HXP.screen.color = 0x353d41;
		
		HXP.screen.smoothing = false;
		
		HXP.scene = new TitleScene();
	}

	public static function main() { new Main(); }

}