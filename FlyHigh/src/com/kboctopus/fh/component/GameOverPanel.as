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
		private var _goTF:TextField;
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
			this._bg = new Image(AssetTool.ins().getAtlas("temp").getTexture("9"));
			this.addChild(this._bg);
			
			// init tf
			this._goTF = new TextField(360, 110, "Game Over", "my_font", 50, 0xffffff);
			this.addChild(this._goTF);
			
			// init btn
			this._returnBtn = new MyButton("return", _clickBtnHandler, 0xffffff);
			this.addChild(this._returnBtn);
			this._againBtn = new MyButton("again", _clickBtnHandler, 0xffffff);
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
		private function _clickBtnHandler(btn:MyButton) : void
		{
			switch(btn.lab)
			{
				case "return":
					returnHandler();
					break;
				case "again":
					againHandler();
					break;
			}
		}
	}
}