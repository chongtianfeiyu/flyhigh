package com.kboctopus.fh.screen
{
	import com.kboctopus.fh.component.Baffle;
	import com.kboctopus.fh.component.GameOverPanel;
	import com.kboctopus.fh.component.PlayTouchPanel;
	import com.kboctopus.fh.component.Role;
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.consts.ConstScreen;
	import com.kboctopus.fh.mode.ClassicMode;
	import com.kboctopus.fh.mode.EasyMode;
	import com.kboctopus.fh.mode.HardMode;
	import com.kboctopus.fh.mode.IPlayMode;
	import com.kboctopus.fh.tools.AssetTool;
	import com.kboctopus.fh.tools.StaticPool;
	import com.kboctopus.steer.geom.Vector2D;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class PlayScreen extends BaseScreen
	{
		private var _showContainer:Sprite;
		private var _winContainer:Sprite;
		
		private var _baffleContainer:Sprite;
		private var _touchPanel:PlayTouchPanel;
		private var _role:Role;
		
		private var _mode:IPlayMode;
		private var _hard:HardMode;
		private var _classic:ClassicMode;
		private var _easy:EasyMode;
		
		private var _ct:int;
		
		public function PlayScreen(manager:IScreenManager)
		{
			super(manager);
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		override public function reset(data:*):void
		{
			this._ct = 0;
			
			if (data=="easy")
			{
				this._mode = this._easy;
			}
			else if (data=="classic")
			{
				this._mode = this._classic;
			}
			else
			{
				this._mode = this._hard;
			}
			this._mode.reset();
			this._mode.score = 0;
			super.reset(data);
		}
		
		private function _createBaffle():void
		{
			this._mode.create();
		}		
		
		override protected function initUI():void
		{
			this._showContainer = new Sprite();
			this.addChild(this._showContainer);
			this._winContainer = new Sprite();
			this.addChild(this._winContainer);
			
			this._baffleContainer = new Sprite();
			this._showContainer.addChild(this._baffleContainer);
			
			this._role = new Role();
			this._role.x = (ConstGame.GAME_W-this._role.width)>>1;
			this._role.y = ConstGame.GAME_H - 280;
			this._showContainer.addChild(this._role);
			
			this._touchPanel = new PlayTouchPanel(this._role);
			this._touchPanel.y = ConstGame.GAME_H - this._touchPanel.height;
			this._touchPanel.x = ConstGame.GAME_W>>1;
			this._showContainer.addChild(this._touchPanel);
			
			_hard = new HardMode(this._baffleContainer, this._role);
			_easy = new EasyMode(this._baffleContainer, this._role);
			_classic = new ClassicMode(this._baffleContainer, this._role);
			
			StaticPool.pushItem(new Baffle());
		}
		
		
		override protected function initEvents():void
		{
			this.addEventListener(Event.ENTER_FRAME, _onUpdateHandler);
			this._touchPanel.initEvent();
		}
		
		
		override protected function removeEvents():void
		{
			this.removeEventListener(Event.ENTER_FRAME, _onUpdateHandler);
			this._touchPanel.removeEvent();
		}
		
		
		public function gameOver():void
		{
			removeEvents();
			this.screenManager.showScreen(ConstScreen.ID_GAME_OVER, this._mode);
			this._mode.clean();
		}
		
		
		private function _onUpdateHandler(e:Event) : void
		{
			if (this._mode == null)
			{
				return;
			}
			_ct++;
			if (_ct >= this._mode.rate)
			{
				_ct = 0;
				_createBaffle();
			}
			
			this._role.applyForces(this._touchPanel.force);
			this._role.move();

			this._mode.checkRole();
			
			if (this._mode.checkOver())
			{
				this.gameOver();
			}
		}

	}
}