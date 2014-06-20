package com.kboctopus.fh.screen
{
	import com.kboctopus.fh.component.BillBoardPanel;
	import com.kboctopus.fh.component.GameOverPanel;
	import com.kboctopus.fh.component.MyButton;
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.consts.ConstScreen;
	import com.kboctopus.fh.mode.IPlayMode;
	import com.kboctopus.fh.sound.SoundManager;
	import com.kboctopus.fh.tools.AssetTool;
	import com.kboctopus.fh.tools.JPGEncoder;
	import com.kboctopus.fh.tools.MyString;
	import com.kboctopus.fh.tools.NativeTool;
	import com.kboctopus.sns.ServiceManager;
	import com.kboctopus.sns.constant.ServiceType;
	
	import flash.display.BitmapData;
	import flash.net.dns.AAAARecord;
	
	import so.cuo.platform.ad.AdManager;
	import so.cuo.platform.ad.AdPosition;
	import so.cuo.platform.ad.AdSize;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	public class GameOverScreen extends BaseScreen
	{
		private var _overPanel:GameOverPanel;
		private var _boardPanel:BillBoardPanel;
		private var _mode:IPlayMode;
		
		public function GameOverScreen(manager:IScreenManager)
		{
			super(manager);
		}
		
		override protected function initUI():void
		{
			this._overPanel = new GameOverPanel();
			this._overPanel.y = ((ConstGame.GAME_H - this._overPanel.height)>>1)-50;
			this._overPanel.x = ((ConstGame.GAME_W - this._overPanel.width)>>1)+10;
			this.addChild(this._overPanel);
			this._overPanel.returnHandler = _return;
			this._overPanel.bbHandler = _showBB;
			
			this._boardPanel = new BillBoardPanel();
		}
		
		
		override public function destroy():void
		{
			this._overPanel.clickAble = false;
			AdManager.getInstance().hideBanner();
			SoundManager.ins().stop();
			this._boardPanel.clickAble = false;
		}
		
		
		override public function reset(data:*):void
		{
			this._mode = data;
			this._overPanel.setResult(data);
			this._overPanel.clickAble = true;
			SoundManager.ins().playBGM("bg");
			this._boardPanel.clickAble = true;
			AdManager.getInstance().showBanner(AdSize.PHONE_PORTRAIT, AdPosition.BOTTOM_CENTER);
		}
		
		
		private function _return():void
		{
			this.screenManager.showScreen(ConstScreen.ID_START, "");
		}
		
		
		private function _showBB():void
		{
			if (this._mode.canBePutBoard)
			{
				this._boardPanel.show(this._mode);
			}
			else
			{
				NativeTool.ins().toast(MyString.data_bad);
			}
		}
	}
}