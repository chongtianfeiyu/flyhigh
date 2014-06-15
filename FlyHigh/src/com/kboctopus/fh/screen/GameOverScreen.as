package com.kboctopus.fh.screen
{
	import com.kboctopus.fh.component.GameOverPanel;
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.consts.ConstScreen;
	
	import so.cuo.platform.baidu.BaiDu;
	import so.cuo.platform.baidu.RelationPosition;
	
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
			
			BaiDu.getInstance().setKeys("debug","debug");
		}
		
		
		override public function destroy():void
		{
			this._panel.clickAble = false;
//			BaiDu.getInstance().hideBanner();
		}
		
		
		override public function reset(data:*):void
		{
			this._panel.setResult(data);
			this._panel.clickAble = true;
			BaiDu.getInstance().showBanner(BaiDu.BANNER,RelationPosition.BOTTOM_CENTER);
		}
		
		
		private function _again():void
		{
			this.screenManager.showScreen(ConstScreen.ID_START, "");
		}
	}
}