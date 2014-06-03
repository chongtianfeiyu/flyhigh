package com.kboctopus.fh.component
{
	import com.kboctopus.fh.tools.AssetTool;
	
	import flash.net.SharedObject;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class GameOverPanel extends Sprite
	{
		private var _bg:Image;
		private var _returnBtn:MyButton;
		private var _againBtn:MyButton;
		private var _scoreTF:TextField;
		private var _bestTF:TextField;
		
		private var _bestV:int;
		private var _so:SharedObject;
		
		public function GameOverPanel()
		{
			this._so = SharedObject.getLocal("flyHigh");
			_bestV = this._so.data.best;
			_initUI();
		}
		
		
		public function setScore(v:int) : void
		{
			if (v > this._bestV)
			{
				this._bestV = v;
				this._so.data.best = this._bestV;
				this._so.flush();
			}
			this._scoreTF.text = v.toString();
			this._bestTF.text = this._bestV.toString();
		}
		
		
		private function _initUI() : void
		{
			// init bg
			this._bg = new Image(AssetTool.ins().getAtlas("temp").getTexture("3_1"));
			this.addChild(this._bg);
			
			this._scoreTF = new TextField(100, 42, "0", "my_font", 24, 0xff000000);
			this._bestTF = new TextField(100, 42, "0", "my_font", 24, 0xff000000);
			this.addChild(this._scoreTF);
			this.addChild(this._bestTF);
			this._scoreTF.x = this._bestTF.x = 194;
			this._scoreTF.y = 110;
			this._bestTF.y = 143;
			this._scoreTF.touchable = this._bestTF.touchable = false;
			
			// init btn
			this._returnBtn = new MyButton("4_2", _clickReturnHandler);
			this.addChild(this._returnBtn);
			this._againBtn = new MyButton("4_1", _clickAgainHandler);
			this.addChild(this._againBtn);
			this._returnBtn.y = this._againBtn.y = 222;
			this._returnBtn.x = 54;
			this._againBtn.x = 234;
		}
		
		
		public var returnHandler:Function;
		public var againHandler:Function;
		private function _clickReturnHandler(btn:MyButton) : void
		{
			returnHandler();
		}
		
		private function _clickAgainHandler(btn:MyButton) : void
		{
			againHandler();
		}
	}
}