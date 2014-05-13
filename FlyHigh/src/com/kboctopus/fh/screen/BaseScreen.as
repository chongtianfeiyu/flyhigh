package com.kboctopus.fh.screen
{
	
	import starling.display.Sprite;
	
	public class BaseScreen extends Sprite
	{
		public var screenManager:IScreenManager;
		
		public function BaseScreen(manager:IScreenManager)
		{
			super();
			this.screenManager = manager;
			this.initUI();
			this.initEvents();
		}
		
		
		protected function initUI() : void
		{
		}
		
		
		protected function initEvents() : void
		{
		}
		
		
		
		protected function removeEvents() : void
		{
		}
		
		
		public function reset() : void
		{
			this.initEvents();
		}
		
		
		public function destroy() : void
		{
			this.removeEvents();
		}
		
		
		
		
	}
}