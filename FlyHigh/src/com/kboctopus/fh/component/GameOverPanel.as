package com.kboctopus.fh.component
{
	import com.kboctopus.fh.tools.AssetTool;
	import com.kboctopus.fh.tools.LocalSaver;
	
	import flash.net.SharedObject;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class GameOverPanel extends Sprite
	{
		private var _bg:Image;
		private var _billboardBtn:MyButton;
		private var _againBtn:MyButton;
		private var _scoreTF:TextField;
		private var _bestTF:TextField;
		
		private var _bestV:int;
		private var _clickAble:Boolean = false;
		
		public function GameOverPanel()
		{
			_bestV = LocalSaver.ins().so.data.best;
			_initUI();
		}
		
		
		public function setScore(v:int) : void
		{
			if (v > this._bestV)
			{
				this._bestV = v;
				LocalSaver.ins().so.data.best = this._bestV;
				LocalSaver.ins().so.flush();
			}
			this._scoreTF.text = v.toString();
			this._bestTF.text = this._bestV.toString();
		}
		
		
		private function _initUI() : void
		{
			// init bg
			this._bg = new Image(AssetTool.ins().getAtlas("ui").getTexture("over"));
			this.addChild(this._bg);
			
			this._scoreTF = new TextField(100, 42, "0", "my_font", 24, 0xff000000);
			this._bestTF = new TextField(100, 42, "0", "my_font", 24, 0xff000000);
			this.addChild(this._scoreTF);
			this.addChild(this._bestTF);
			this._scoreTF.x = this._bestTF.x = 157;
			this._scoreTF.y = 195;
			this._bestTF.y = 235;
			this._scoreTF.touchable = this._bestTF.touchable = false;
			
			// init btn
			this._billboardBtn = new MyButton("btn_billboard", _clickReturnHandler);
			this.addChild(this._billboardBtn);
			this._billboardBtn.touchable = false;
			this._againBtn = new MyButton("btn_again", _clickAgainHandler);
			this.addChild(this._againBtn);
			this._billboardBtn.y = this._againBtn.y = 300;
			this._billboardBtn.x = 54;
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

		public function set clickAble(value:Boolean):void
		{
			if (_clickAble == value)
			{
				return;
			}
			_clickAble = value;
			this._againBtn.clickAble = _clickAble;
		}

	}
}