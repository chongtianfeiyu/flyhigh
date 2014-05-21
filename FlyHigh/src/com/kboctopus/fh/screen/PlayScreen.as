package com.kboctopus.fh.screen
{
	import com.kboctopus.fh.component.Baffle;
	import com.kboctopus.fh.component.GameOverPanel;
	import com.kboctopus.fh.component.PlayTouchPanel;
	import com.kboctopus.fh.component.Role;
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.consts.ConstScreen;
	import com.kboctopus.fh.tools.AssetTool;
	import com.kboctopus.steer.geom.Vector2D;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class PlayScreen extends BaseScreen
	{
		private var _baffleContainer:Sprite;
		private var _bg:Image;
		private var _touchPanel:PlayTouchPanel;
		private var _role:Role;
		private var _gameOverPanel:GameOverPanel;
		
		private var _force:Vector2D = new Vector2D();
		
		private var _showBaffle:Vector.<Baffle> = new Vector.<Baffle>();
		private var _poolBaffle:Vector.<Baffle> = new Vector.<Baffle>();
		
		private var _createBaffleTimer:Timer;
		
		private var _score:Number;
		
		public function PlayScreen(manager:IScreenManager)
		{
			_initTimer();
			super(manager);
		}
		
		
		private function _initTimer() : void
		{
			this._createBaffleTimer = new Timer(4000);
			this._createBaffleTimer.addEventListener(TimerEvent.TIMER, _createBaffle);
		}
		
		
		override public function reset():void
		{
			super.reset();
			this.resume();
			this._score = 0;
			var len:uint = this._showBaffle.length;
			var b:Baffle;
			while(len--)
			{
				b = this._showBaffle.pop();
				this._baffleContainer.removeChild(b);
				this._poolBaffle.push(b);
			}
		}
		
		
		private function againHandler() : void
		{
			this.reset();
			this.removeChild(this._gameOverPanel);
		}
		
		
		private function returnHandler() : void
		{
			this.removeChild(this._gameOverPanel);
			this.pause();
			this.screenManager.showScreen(ConstScreen.ID_START);
		}
		
		
		private function _createBaffle(event:TimerEvent):void
		{
			var baffle:Baffle;
			if (this._poolBaffle.length>0)
			{
				baffle = this._poolBaffle.pop();
			}
			else
			{
				baffle = new Baffle();
			}
			baffle.reset();
			this._baffleContainer.addChild(baffle);
			this._showBaffle.push(baffle);
		}		
		
		override protected function initUI():void
		{
			this._baffleContainer = new Sprite();
			this.addChild(this._baffleContainer);
			
			this._role = new Role();
			this._role.x = (ConstGame.GAME_W-this._role.width)>>1;
			this._role.y = 580;
			this.addChild(this._role);
			
			this._touchPanel = new PlayTouchPanel();
			this._touchPanel.y = ConstGame.GAME_H - this._touchPanel.height;
			this.addChild(this._touchPanel);
			
			this._gameOverPanel = new GameOverPanel();
			this._gameOverPanel.x = 60;
			this._gameOverPanel.y = 250;
			this._gameOverPanel.againHandler = this.againHandler;
			this._gameOverPanel.returnHandler = this.returnHandler;
		}
		
		
		override protected function initEvents():void
		{
			this.addEventListener(Event.ENTER_FRAME, _onUpdateHandler);
			this._touchPanel.addEventListener(TouchEvent.TOUCH, _onTouchPanelHandler);
		}
		
		
		override protected function removeEvents():void
		{
			this.removeEventListener(Event.ENTER_FRAME, _onUpdateHandler);
			this._touchPanel.removeEventListener(TouchEvent.TOUCH, _onTouchPanelHandler);
		}
		
		
		public function pause():void
		{
			this._createBaffleTimer.stop();
			removeEvents();
		}
		
		
		public function resume():void
		{
			this._createBaffleTimer.start();
			initEvents();
		}
		
		
		private function _onUpdateHandler(e:Event) : void
		{
			this._role.applyForces(this._force);
			this._role.move();

			if (this._role.x < 0)
			{
				this._role.x += ConstGame.GAME_W;
			} else if (this._role.x > ConstGame.GAME_W)
			{
				this._role.x -= ConstGame.GAME_W;
			}
			
			// check hit
			for each(var b:Baffle in this._showBaffle)
			{
				if (b.hitRole(this._role))
				{
					this.pause();
					this.addChild(this._gameOverPanel);
					trace("game over:" + this._score);
				}
				
				b.move();
				if (b.out())
				{
					this._score += 100;
					this._baffleContainer.removeChild(b);
					this._poolBaffle.push(this._showBaffle.shift());
				}
			}
		}
		
		
		private function _onTouchPanelHandler(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_touchPanel);
			if (touch == null)
			{
				return;
			}
			
			switch(touch.phase) 
			{
				case TouchPhase.BEGAN:
				case TouchPhase.MOVED:
					this._force.x = (touch.globalX-ConstGame.GAME_W*.5)/24;
					break;
				case TouchPhase.ENDED:
					this._force.x = 0;
					break;
				default:
					break;
			}
		}
	}
}