package statics.sky;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Mask;
import com.haxepunk.tweens.misc.Alarm;
import com.haxepunk.Tween;
import openfl.display.BitmapData;
import openfl.events.Event;

	class Sky extends Entity 
	{
		
		private var sprite_day:Image = new Image("gfx/sky/back_day.png");
		private var sprite_dusk:Image = new Image("gfx/sky/back_dusk.png");
		private var sprite_dawn:Image = new Image("gfx/sky/back_dawn.png");
		
		private var thunder:Image = new Image(new BitmapData(800, 600, false, 0xFFFFFFFF));
		private var thunder2:Image = new Image(new BitmapData(800, 600, false, 0xFFFFFFFF));
		
		private var light:Bool = false;
		private var alarm:Alarm; private var alarm2:Alarm;
		
		private var toggle:Int = 0;
		
		public function new() 
		{
			
			super(0, 0);
			
			x = -HXP.screen.x / HXP.screen.scaleX;
			
			
			addGraphic(sprite_dawn);
			addGraphic(sprite_day);
			addGraphic(sprite_dusk);
			
			addGraphic(thunder);
			
			
			sprite_day.alpha = 0;
			sprite_dusk.alpha = 0;
			sprite_dawn.alpha = 0;
			
			thunder.alpha = 0;
			
			layer = 98;
			
			graphic.scrollX = graphic.scrollY = 0;
			
			sprite_dawn.alpha = 1;
			
			
			addTween(alarm = new Alarm((Math.random() * 20) + 2, lightning, TweenType.Persist), true);
			addTween(alarm2 = new Alarm((Math.random() * 2) + 1, lightningdone, TweenType.Persist), false);
			
			resize();
			
			HXP.stage.addEventListener(Event.RESIZE, function (e:Event) {
				resize();
			});
		}
		
		override public function update():Void
		{
			//if (toggle == 1)
			//{
				//dawn
				if (Globals.time >= 180 && Globals.time <= 360)
				{
					sprite_dawn.alpha = (Globals.time-180)/(360-180);
				}
				//day
				if (Globals.time >= 360 && Globals.time <= 540)
				{
					sprite_day.alpha = (Globals.time-360)/(540-360);
				}
				if (Globals.time >= 540 && Globals.time <= 900)
				{
					sprite_dawn.alpha = 1;
					sprite_day.alpha = 1;
					sprite_dusk.alpha = 0;
				}
				//dusk
				if (Globals.time >= 900 && Globals.time <= 1080)
				{
					sprite_dusk.alpha = (Globals.time-900) / (1080 - 900);
				}
				//night
				if (Globals.time >= 1080 && Globals.time <= 1260)
				{
					sprite_day.alpha = 0;
					sprite_dawn.alpha = 0;
					sprite_dusk.alpha = 1-((Globals.time-1080) / (1260 - 1080));
				}
				if (Globals.time >= 1260 || Globals.time <= 180)
				{
					sprite_dawn.alpha = 0;
					sprite_day.alpha = 0;
					sprite_dusk.alpha = 0;
				}
				
				//storm
				if (Globals.wetter == 3)
				{
					if (light)
					{
						thunder.alpha = Math.random()/2;
					}
				}
				
				thunder2.color = Globals.colormount;
				super.update();
			//}
			//toggle = (toggle + 1) % 10;
		}
		
		private function lightning(e:Dynamic = null)
		{
			
			light = true;
			alarm2.reset((Math.random() * 2) + 1);
			
		}
		
		private function lightningdone(e:Dynamic = null)
		{
			
			light = false;
			thunder.alpha = 0;
			alarm.reset((Math.random() * 10) + 1);
			
		}
		
	private function resize():Void
	{
		
		x = -HXP.screen.x / HXP.screen.scaleX;
		y = -HXP.screen.y / HXP.screen.scaleY;
		
		thunder2.scaleX = thunder.scaleX = sprite_dawn.scaleX = sprite_day.scaleX = sprite_dusk.scaleX = HXP.stage.stageWidth / 800 / HXP.screen.scaleX;
		thunder2.scaleY = thunder.scaleY = sprite_dawn.scaleY = sprite_day.scaleY = sprite_dusk.scaleY = HXP.stage.stageHeight / 360 / HXP.screen.scaleY;
		
	}
		
	}
