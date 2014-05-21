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
		private var _tf:TextField;
		private var _clickHandler:Function;
		
		public function MyButton(lab:String, click:Function, color:uint=0)
		{
			this._clickHandler = click;
			_initUI(color);
			_initEvent();
			this.lab = lab;
		}
		
		
		private function _initUI(color:uint) : void
		{
			this._bg = new Image(AssetTool.ins().getAtlas("temp").getTexture("2"));
			this.addChild(this._bg);
			
			this._tf = new TextField(110, 50, "", "my_font", 40, color);
			this._tf.touchable = false;
			this.addChild(this._tf);
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
				this._clickHandler(this);
			}
		}
		
		
		public function set lab(v:String) : void
		{
			this._tf.text = v;
		}
		
		public function get lab() : String
		{
			return this._tf.text;
		}
	}
}