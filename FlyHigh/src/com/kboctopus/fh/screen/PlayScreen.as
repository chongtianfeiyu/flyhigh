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
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.PDParticleSystem;
	import starling.text.TextField;

	public class PlayScreen extends BaseScreen
	{
		private var _showContainer:Sprite;
		private var _winContainer:Sprite;
		
		private var _baffleContainer:Sprite;
		private var _bg:Image;
		private var _touchPanel:PlayTouchPanel;
		private var _role:Role;
		private var _gameOverPanel:GameOverPanel;
		
		private var _showBaffle:Vector.<Baffle> = new Vector.<Baffle>();
		private var _poolBaffle:Vector.<Baffle> = new Vector.<Baffle>();
		
		private var _pdParticle:PDParticleSystem;
		private var _score:Number;
		
		private var _ct:int;
		
		public function PlayScreen(manager:IScreenManager)
		{
			super(manager);
		}
		
		override public function destroy():void
		{
			super.destroy();
			this._pdParticle.stop();
		}
		
		override public function reset():void
		{
			super.reset();
			this._ct = 0;
			this.score = 0;
			var len:uint = this._showBaffle.length;
			var b:Baffle;
			while(len--)
			{
				b = this._showBaffle.pop();
				this._baffleContainer.removeChild(b);
				this._poolBaffle.push(b);
			}
			this._pdParticle.start();
			if (this._gameOverPanel.parent != null)
			{
				this._winContainer.removeChild(this._gameOverPanel);
			}
		}
		
		
		private function againHandler() : void
		{
			reset();
		}
		
		
		private function returnHandler() : void
		{
		}
		
		
		private function _createBaffle():void
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
			this._pdParticle = AssetTool.ins().getParticle("p1");
			this._pdParticle.emitterX = ConstGame.GAME_W>>1;
			this._pdParticle.emitterY = ConstGame.GAME_H>>1;
			this.addChild(this._pdParticle);
			Starling.juggler.add(this._pdParticle);
			
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
			
			this._gameOverPanel = new GameOverPanel();
			this._gameOverPanel.x = (ConstGame.GAME_W-this._gameOverPanel.width)>>1;
			this._gameOverPanel.y = (ConstGame.GAME_H-this._gameOverPanel.height)>>1;
			this._gameOverPanel.againHandler = this.againHandler;
			this._gameOverPanel.returnHandler = this.returnHandler;
			
			tf = new TextField(400, 60, "0", "Verdana", 30, 0xff000000);
			tf.text = ConstGame.GAME_W + " : " + ConstGame.GAME_H;
			this._showContainer.addChild(tf);
		}
		
		private function _testTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(tf, TouchPhase.BEGAN);
			if (touch != null)
			{
				this._speed+=0.3;
				tf.text = this._speed.toString();
			}
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
			this._pdParticle.stop();
			this._gameOverPanel.setScore(this._score);
			this._winContainer.addChild(this._gameOverPanel);
		}
		
		
		private var _speed:Number = 3;
		private var tf:TextField;
		private function _onUpdateHandler(e:Event) : void
		{
			_ct++;
			if (_ct >= 100)
			{
				_ct = 0;
				_createBaffle();
			}
			
			this._role.applyForces(this._touchPanel.force);
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
					this.gameOver();
					return;
				}
				
				b.move(_speed);
				if (b.out())
				{
					this.score = this._score + 1;
					this._baffleContainer.removeChild(b);
					this._poolBaffle.push(this._showBaffle.shift());
				}
			}
		}

		private function set score(value:Number):void
		{
			_score = value;
			this.tf.text = this._score.toString();
		}

	}
}