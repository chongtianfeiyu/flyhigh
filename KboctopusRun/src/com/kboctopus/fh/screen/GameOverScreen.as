package com.kboctopus.fh.screen
{
	import com.kboctopus.fh.component.GameOverPanel;
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.consts.ConstScreen;
	import com.kboctopus.fh.sound.SoundManager;
	
	import so.cuo.platform.ad.AdManager;
	import so.cuo.platform.ad.AdPosition;
	import so.cuo.platform.ad.AdSize;
	
	import starling.text.TextField;

	public class GameOverScreen extends BaseScreen
	{
		private var _panel:GameOverPanel;
		
		public function GameOverScreen(manager:IScreenManager)
		{
			super(manager);
		}
		
		override protected function initUI():void
		{
			this._panel = new GameOverPanel();
			this._panel.y = ((ConstGame.GAME_H - this._panel.height)>>1)-50;
			this._panel.x = ((ConstGame.GAME_W - this._panel.width)>>1)+10;
			this.addChild(this._panel);
			this._panel.againHandler = _again;
		}
		
		
		override public function destroy():void
		{
			this._panel.clickAble = false;
			AdManager.getInstance().hideBanner();
		}
		
		
		override public function reset(data:*):void
		{
			this._panel.setResult(data);
			this._panel.clickAble = true;
			AdManager.getInstance().showBanner(AdSize.PHONE_PORTRAIT, AdPosition.BOTTOM_CENTER);
			SoundManager.ins().getSound("over").play();
		}
		
		
		private function _again():void
		{
			this.screenManager.showScreen(ConstScreen.ID_START, "");
		}
	}
}