package com.kboctopus.fh.component
{
	import com.kboctopus.fh.tools.AssetTool;
	
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
		
		public function GameOverPanel()
		{
			_initUI();
			_initEvent();
		}
		
		
		
		private function _initUI() : void
		{
			// init bg
			this._bg = new Image(AssetTool.ins().getAtlas("temp").getTexture("5_1"));
			this.addChild(this._bg);
			
			// init btn
			this._returnBtn = new MyButton("6_1", _clickReturnHandler);
			this.addChild(this._returnBtn);
			this._againBtn = new MyButton("6_2", _clickAgainHandler);
			this.addChild(this._againBtn);
			this._returnBtn.y = this._againBtn.y = 130;
			this._returnBtn.x = 40;
			this._againBtn.x = 210;
		}
		
		
		private function _initEvent() : void
		{
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