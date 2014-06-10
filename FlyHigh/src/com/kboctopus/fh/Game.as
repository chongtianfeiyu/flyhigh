package com.kboctopus.fh
{
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.consts.ConstScreen;
	import com.kboctopus.fh.screen.BaseScreen;
	import com.kboctopus.fh.screen.GameOverScreen;
	import com.kboctopus.fh.screen.IScreenManager;
	import com.kboctopus.fh.screen.PlayScreen;
	import com.kboctopus.fh.screen.StartScreen;
	import com.kboctopus.fh.tools.AssetTool;
	
	import flash.utils.Dictionary;
	
	import starling.animation.Transitions;
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
			this._currentScreen.reset("");
			
			screen = new PlayScreen(this);
			screen.visible = false;
			this.addChild(screen);
			this._screenDic[ConstScreen.ID_PLAY] = screen;
			
			screen = new GameOverScreen(this);
			screen.visible = false;
			this.addChild(screen);
			this._screenDic[ConstScreen.ID_GAME_OVER] = screen;
		}
		
		
		public function showScreen(id:int, data:*) : void
		{
			_currentScreen.destroy();
			Starling.juggler.tween(_currentScreen, .5, {
				transition: Transitions.EASE_IN_OUT,
				alpha: 0,
				onComplete: function() : void
				{
					_currentScreen.visible = false;
					_currentScreen = _screenDic[id];
					_currentScreen.reset(data);
					_currentScreen.visible = true;
					Starling.juggler.tween(_currentScreen, .5, {
						transition: Transitions.EASE_IN_OUT,
						alpha: 1
					});
				}
			});
		}
	}
}