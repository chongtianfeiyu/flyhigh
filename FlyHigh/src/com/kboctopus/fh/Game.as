package com.kboctopus.fh
{
	import com.kboctopus.fh.component.FirstTip;
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.consts.ConstScreen;
	import com.kboctopus.fh.screen.BaseScreen;
	import com.kboctopus.fh.screen.GameOverScreen;
	import com.kboctopus.fh.screen.IScreenManager;
	import com.kboctopus.fh.screen.PlayScreen;
	import com.kboctopus.fh.screen.StartScreen;
	import com.kboctopus.fh.tools.AssetTool;
	import com.kboctopus.fh.tools.LocalSaver;
	
	import flash.utils.Dictionary;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Sprite;
	
	public class Game extends Sprite implements IScreenManager
	{
		private var _currentScreen:BaseScreen;
		private var _screenDic:Dictionary = new Dictionary();
		
		private var _hasShowTip:Boolean = true;
		private var _tip:FirstTip;
		
		public function Game()
		{
			_hasShowTip = LocalSaver.ins().so.data.hasShowTip;
			if (!_hasShowTip)
			{
				_tip = new FirstTip(); 
			}
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
					if (!_hasShowTip)
					{
						_hasShowTip = true;
						LocalSaver.ins().so.data.hasShowTip = _hasShowTip;
						LocalSaver.ins().so.flush();
						Starling.current.nativeStage.addChild(_tip);
						_tip.clickHandler = show;
					}
					else
					{
						show();
					}
					
					function show():void
					{
						_currentScreen.visible = true;
						_currentScreen.alpha = 0;
						_currentScreen.reset(data);
						Starling.juggler.tween(_currentScreen, .5, {
							transition: Transitions.EASE_IN_OUT,
							alpha: 1
						});
					}
				}
			});
		}
	}
}