package com.kboctopus.fh.component
{
	import com.kboctopus.fh.tools.AssetTool;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class MyButton extends Sprite
	{
		private var _bg:Image;
		private var _clickHandler:Function;
		
		public function MyButton(tex:String, click:Function)
		{
			this._clickHandler = click;
			_initUI(tex);
			_initEvent();
		}
		
		
		private function _initUI(tex:String) : void
		{
			this._bg = new Image(AssetTool.ins().getAtlas("temp").getTexture(tex));
			this.addChild(this._bg);
		}
		
		
		private function _initEvent() : void
		{
			this.addEventListener(TouchEvent.TOUCH, _onTouchHandler);
		}
		
		
		private function _onTouchHandler(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this, TouchPhase.BEGAN);
			if (touch != null)
			{
				this.y += 3;
				return;
			}
			
			touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch != null)
			{
				this.y -= 3;
				_clickHandler(this);
			}
		}
	}
}