package com.kboctopus.fh
{
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.consts.ConstScreen;
	import com.kboctopus.fh.screen.BaseScreen;
	import com.kboctopus.fh.screen.IScreenManager;
	import com.kboctopus.fh.screen.PlayScreen;
	import com.kboctopus.fh.screen.StartScreen;
	import com.kboctopus.fh.tools.AssetTool;
	
	import flash.utils.Dictionary;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	
	public class Game extends Sprite implements IScreenManager
	{
		private var _currentScreen:BaseScreen;
		private var _screenDic:Dictionary = new Dictionary();
		
		public function Game()
		{
			super();
		}
		

		public function start() : void
		{
			var screen:BaseScreen = new StartScreen(this);
			this._currentScreen = screen;
			this.addChild(screen);
			this._screenDic[ConstScreen.ID_START] = screen;
			
			screen = new PlayScreen(this);
			screen.visible = false;
			this.addChild(screen);
			this._screenDic[ConstScreen.ID_PLAY] = screen;
		}
		
		
		public function showScreen(id:int, data:*) : void
		{
			//temp
			_currentScreen.destroy();
			_currentScreen.visible = false;
			
			_currentScreen = _screenDic[id];
			_currentScreen.reset(data);
			_currentScreen.visible = true;
		}
	}
}