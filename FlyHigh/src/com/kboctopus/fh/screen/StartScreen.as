package com.kboctopus.fh.screen
{
	import com.kboctopus.fh.consts.ConstScreen;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;

	public class StartScreen extends BaseScreen
	{
		private var _bg:Image;
		private var _startBtn:Button;
		
		public function StartScreen(manager:IScreenManager)
		{
			super(manager);
		}
		
		
		override protected function initUI():void 
		{
			// init bg
			
			// init btn
		}
		
		
		override protected function initEvents():void
		{
			this._startBtn.addEventListener(Event.TRIGGERED, _onStartHandler);
		}
		
		
		private function _onStartHandler(e:Event) : void
		{
			this.screenManager.showScreen(ConstScreen.ID_PLAY);
		}
	}
}