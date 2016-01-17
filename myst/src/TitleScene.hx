import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.tweens.misc.VarTween;
import com.haxepunk.utils.Ease;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import openfl.ui.Mouse;

class TitleScene extends Scene
{
	
	private var title:Spritemap = new Spritemap("graphics/title.png", 75, 120);
	
	private var title_click:Image = new Image("graphics/title_click.png");
	
	private var text:Text = new Text("", -1, -1, 801, 601);
	
	private var pressed:Bool = false;

	override public function begin()
	{
		
		title.add("idle", [0, 1, 2, 3], 10); title.play("idle");
		title.centerOrigin();
		
		addGraphic(title, -10, HXP.halfWidth, HXP.halfHeight);
		
		
		title_click.alpha = 0;
		title_click.centerOrigin();
		
		addGraphic(title_click, -10, HXP.halfWidth, HXP.height * 0.9);
		
		
		text.color = 0xd5d8da;
		text.font = "font/Perfect DOS VGA 437 Win.ttf";
		text.size = 16;
		text.smooth = false;
		text.wordWrap = true;
		addGraphic(text, -15);
		
		
		var tweener:VarTween = new VarTween(click_end); tweener.tween(title_click, "alpha", 1, 2, Ease.expoInOut);
		addTween(tweener, true);
		
	}
	
	private function click_end(e:Dynamic = null):Void
	{
		
		var tweener:VarTween = new VarTween(click_end);
		
		tweener.tween(title_click, "alpha", 1-title_click.alpha, 2, Ease.expoInOut);
		
		addTween(tweener, true);
		
	}
	
	override public function update():Void
	{
		
		if (Input.pressed(Key.X))
		{
			
			pressed = true;
			
			title_click.visible = false;
			
			
		}
		
		if (pressed)
		{
			
			text.text += HXP.choose("░", "▒", "▓", "█") + HXP.choose("░", "▒", "▓", "█") + HXP.choose("░", "▒", "▓", "█");
		}
		
		super.update();
		
	}

}