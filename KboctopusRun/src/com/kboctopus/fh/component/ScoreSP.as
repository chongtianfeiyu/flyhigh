package com.kboctopus.fh.component
{
	import com.kboctopus.fh.tools.StaticPool;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class ScoreSP extends Sprite
	{
		private var _tf:TextField;
		
		public function ScoreSP()
		{
			this._tf = new TextField(70, 40, "", "my_font", 32);
			this._tf.x = -35;
			this._tf.y = -20;
			this.addChild(this._tf);
			this._tf.touchable = this.touchable = false;
		}
		
		
		public function show(v:int, sx:Number, sy:Number):void
		{
			if (v<0)
			{
				this._tf.color = 0xff000000;
				this._tf.text = v.toString();
			}
			else
			{
				this._tf.color = 0xff777777;
				this._tf.text = "+" + v.toString();
			}
			this.scaleX = this.scaleY = 1;
			this.alpha = 1;
			this.visible = true;
			this.x = sx;
			this.y = sy;
			
			var sp:ScoreSP = this;
			Starling.juggler.tween(this, 1, {
				transition: Transitions.EASE_IN_OUT,
				alpha: .1,
				scaleX: .7,
				scaleY: .7,
				onComplete: function() : void
				{
					sp.visible = false;
					sp.removeFromParent();
					StaticPool.pushItem(sp);
				}
			});
		}
	}
}