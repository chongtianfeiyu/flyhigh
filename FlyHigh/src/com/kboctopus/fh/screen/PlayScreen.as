package com.kboctopus.fh.screen
{
//	import com.codealchemy.ane.admobane.AdMobManager;
//	import com.codealchemy.ane.admobane.AdMobPosition;
//	import com.codealchemy.ane.admobane.AdMobSize;
//	import com.dabing.airextension.GetAndroidPhoneSn;
	import com.kboctopus.fh.component.Baffle;
	import com.kboctopus.fh.component.GameOverPanel;
	import com.kboctopus.fh.component.PlayTouchPanel;
	import com.kboctopus.fh.component.Role;
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.consts.ConstScreen;
	import com.kboctopus.fh.mode.ClassicMode;
	import com.kboctopus.fh.mode.IPlayMode;
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
		
		private var _mode:ClassicMode;
		
		private var _pdParticle:PDParticleSystem;
		private var _ct:int;
		
//		private var _flashgetsn:GetAndroidPhoneSn;
		private var _imei:String;
		
		
//		private var adMobManager:AdMobManager;
//		private var isShow:Boolean = false;
		
		public function PlayScreen(manager:IScreenManager)
		{
//			this._flashgetsn = new GetAndroidPhoneSn();
//			this._imei = this._flashgetsn.getSn(1);
			super(manager);
		}
		
		override public function destroy():void
		{
			super.destroy();
			this._pdParticle.stop();
		}
		
		override public function reset(data:*):void
		{
			super.reset(data:*);
			this._ct = 0;
			this._mode.score = 0;
			this._mode.clean();
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
			this._mode.create();
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
			
			this._showContainer.addChild(tf);
			
			_mode = new ClassicMode(this._baffleContainer, this._role);
			
//			adMobManager = AdMobManager.manager;
//			tf.text = adMobManager.isSupported.toString();
//			if(adMobManager.isSupported){
//				adMobManager.verbose = true;
//				adMobManager.operationMode = AdMobManager.TEST_MODE;
//				
//				adMobManager.bannersAdMobId = "ca-app-pub-1069429310304368/4278640937";
////				adMobManager.bannersAdMobId = "a152834c2b8cce6";
//				
////				adMobManager.gender = AdMobManager.GENDER_MALE;
////				adMobManager.birthYear = 1996;
////				adMobManager.birthMonth = 1;
////				adMobManager.birthDay = 24;
////				adMobManager.isCDT = true;
//				adMobManager.createBanner(AdMobSize.BANNER,AdMobPosition.TOP_CENTER,"BottomBanner1", null, true);
//				
//				adMobManager.showInterstitial();
//				adMobManager.showAllBanner();
//				
//				tf.text = "showAllBanner";
//			}		
			
//			var admob:Admob= Admob.getInstance();
//			if(admob.supportDevice){
//				admob.setKeys("ca-app-pub-1069429310304368/4278640937");
//				admob.showBanner(Admob.BANNER,AdmobPosition.TOP_CENTER);
//			}
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
			this._gameOverPanel.setScore(this._mode.score);
			this._winContainer.addChild(this._gameOverPanel);
		}
		
		
		private var tf:TextField;
		private function _onUpdateHandler(e:Event) : void
		{
			_ct++;
			if (_ct >= this._mode.rate)
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
			
			if (this._mode.checkOver())
			{
				this.gameOver();
			}
		}

	}
}