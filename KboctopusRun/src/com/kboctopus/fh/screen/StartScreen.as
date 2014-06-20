package com.kboctopus.fh.screen
{
	import com.kboctopus.fh.component.MyButton;
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.consts.ConstScreen;
	import com.kboctopus.fh.sound.SoundManager;
	import com.kboctopus.fh.tools.AssetTool;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.events.Event;
	import starling.textures.Texture;

	public class StartScreen extends BaseScreen
	{
		private var _classicBtn:MyButton;
		private var _easyBtn:MyButton;
		private var _hardBtn:MyButton;
		private var _head:Image;
		private var _top:QuadBatch;
		private var _bottom:QuadBatch;
		
		public function StartScreen(manager:IScreenManager)
		{
			super(manager);
		}
		
		
		override public function destroy():void
		{
			super.destroy();
			this._classicBtn.clickAble = this._easyBtn.clickAble = this._hardBtn.clickAble = false;
			SoundManager.ins().stop();
		}
		
		override public function reset(data:*):void
		{
			super.reset(data);
			this._classicBtn.clickAble = this._easyBtn.clickAble = this._hardBtn.clickAble = true;
			SoundManager.ins().playBGM("bg");
		}
		
		
		override protected function initUI():void 
		{
			//init img 
			var hua:Image = new Image(AssetTool.ins().getAtlas("ui").getTexture("hua"));
			this._top = new QuadBatch();
			var w:Number = hua.width;
			this._top.addImage(hua);
			while(this._top.width < ConstGame.GAME_W)
			{
				hua.x += w-1;
				this._top.addImage(hua);
			}
			this._top.y = 80-hua.height;
			
			this._bottom = this._top.clone();
			this._bottom.scaleY = -1;
			this._bottom.y = ConstGame.GAME_H-80+this._bottom.height;
			
			this.addChild(this._top);
			this.addChild(this._bottom);
			
			this._head = new Image(AssetTool.ins().getAtlas("ui").getTexture("head"));
			this.addChild(this._head);
			this._head.x = (ConstGame.GAME_W-this._head.width)>>1;
			
			// init btn
			this._classicBtn = new MyButton("btn_classic", _onClassicHandler);
			this.addChild(this._classicBtn);
			this._easyBtn = new MyButton("btn_easy", _onEasyHandler);
			this.addChild(this._easyBtn);
			this._hardBtn = new MyButton("btn_hard", _onHardHandler);
			this.addChild(this._hardBtn);
			
			this._hardBtn.x = this._easyBtn.x = this._classicBtn.x = (ConstGame.GAME_W-200)>>1;
			var startY:int = ((ConstGame.GAME_H - 540)>>1) -30;
			this._head.y = startY;
			this._easyBtn.y = this._head.y + 260;
			this._hardBtn.y = this._easyBtn.y + 96;
			this._classicBtn.y = this._hardBtn.y + 96;
		}
		
		private function _onClassicHandler(v:MyButton) : void
		{
			this.screenManager.showScreen(ConstScreen.ID_PLAY, "classic");
		}
		
		
		private function _onEasyHandler(v:MyButton) : void
		{
			this.screenManager.showScreen(ConstScreen.ID_PLAY, "easy");
		}
		
		private function _onHardHandler(v:MyButton) : void
		{
			this.screenManager.showScreen(ConstScreen.ID_PLAY, "hard");
		}
	}
}