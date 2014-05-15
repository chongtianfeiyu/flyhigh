package com.kboctopus.fh.screen
{
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.consts.ConstScreen;
	import com.kboctopus.fh.tools.AssetTool;
	import com.kboctopus.sns.ServiceManager;
	import com.kboctopus.sns.constant.ServiceType;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;

	public class StartScreen extends BaseScreen
	{
		private var _bg:Image;
		private var _startBtn:Button;
		
		// temp
		private var _shareQQ:Button;
		private var _shareSina:Button;
		private var testBa:ByteArray;
		private var _ldr:URLLoader;
		
		public function StartScreen(manager:IScreenManager)
		{
			super(manager);
			
			/**初始化腾讯平台服务*/
			ServiceManager.ins().initConfig(ServiceType.TENCENT, "", "801386256", "6fa520a3c9b35b3a1fc16f117ae7a9a0", "http://www.sharesdk.cn");
			ServiceManager.ins().initConfig(ServiceType.SINA, "", "3912828254", "1c72050a8b871cb46a1759dc5c77fa63",  "https://api.weibo.com/oauth2/default.html");
		}
		
		
		override protected function initUI():void 
		{
			// init bg
			
			// init btn
			this._startBtn = new Button(AssetTool.ins().getAtlas("temp").getTexture("2"));
			this._startBtn.x = (ConstGame.GAME_W-this._startBtn.width)>>1;
			this._startBtn.y = (ConstGame.GAME_H-this._startBtn.height)>>1;
			this.addChild(this._startBtn);
			
			// temp
			this._shareQQ = new Button(AssetTool.ins().getAtlas("temp").getTexture("5"));
			this._shareQQ.x = 20;
			this._shareQQ.y = 20;
			this.addChild(this._shareQQ);
			this._shareSina = new Button(AssetTool.ins().getAtlas("temp").getTexture("6"));
			this._shareSina.x = 20;
			this._shareSina.y = 100;
			this.addChild(this._shareSina);
			_ldr = new URLLoader();
			_ldr.dataFormat = URLLoaderDataFormat.BINARY;
			_ldr.addEventListener(flash.events.Event.COMPLETE, loadComplete);
			_ldr.load(new URLRequest("assets/ui/temp.png"));
		}
		
				
		override protected function initEvents():void
		{
			this._startBtn.addEventListener(starling.events.Event.TRIGGERED, _onStartHandler);
			
			// temp
			this._shareQQ.addEventListener(starling.events.Event.TRIGGERED, _shareQQHandler);
			this._shareSina.addEventListener(starling.events.Event.TRIGGERED, _shareSinaHandler);
		}
		
		
		override protected function removeEvents():void
		{
			this._startBtn.removeEventListener(starling.events.Event.TRIGGERED, _onStartHandler);
			
			// temp
			this._shareQQ.removeEventListener(starling.events.Event.TRIGGERED, _shareQQHandler);
			this._shareSina.removeEventListener(starling.events.Event.TRIGGERED, _shareSinaHandler);
		}
		
		// temp
		private function _shareQQHandler(e:starling.events.Event) : void
		{
			ServiceManager.ins().authAndShare(ServiceType.TENCENT, "黑色的一片", testBa, shareBack, shareError);
		}
		private function _shareSinaHandler(e:starling.events.Event) : void
		{
			ServiceManager.ins().authAndShare(ServiceType.SINA, "黑色的一片", testBa, shareBack, shareError);
		}
		private function shareBack(result:String):void
		{
			trace("shareBack:" + result);
		}
		private function shareError(result:String):void
		{
			trace("shareError:" + result);
		}
		protected function loadComplete(event:flash.events.Event):void
		{
			this.testBa = this._ldr.data;
		}
		
		private function _onStartHandler(e:starling.events.Event) : void
		{
			this.screenManager.showScreen(ConstScreen.ID_PLAY);
		}
	}
}