package
{
	import com.kboctopus.fh.Game;
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.tools.AssetTool;
	import com.kboctopus.fh.tools.LocalSaver;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	[SWF(frameRate="60")]
	public class FlyHigh extends Sprite
	{
		private var _myStarling:Starling;
		private var _launchBG:Sprite;
		private var _launchImg:Loader;
		private var _starlingHasInit:Boolean = false;
		private var _launchInterval:uint;
		
		public function FlyHigh()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			ConstGame.LANG = (Capabilities.language.substr(0, 2) == "zh") ? "zh" : "en";
				
			this.mouseEnabled = this.mouseChildren = false;
			this.loaderInfo.addEventListener(flash.events.Event.COMPLETE, _loaderInfo_completeHandler);
		}
		
		private function _showLaunchImg() : void
		{
			_launchImg = new Loader();
			_launchImg.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, _loadLaunchComplete);
			_launchImg.load(new URLRequest("assets/ui/kboctopus_logo.png"));
		}
		
		
		protected function _loadLaunchComplete(event:flash.events.Event):void
		{
			_launchImg.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, _loadLaunchComplete);
			this._launchImg.x = (ConstGame.GAME_W-this._launchImg.width)>>1;
			this._launchImg.y = ((ConstGame.GAME_H-this._launchImg.height)>>1)-50;
			this._launchBG = new Sprite();
			this.addChild(this._launchBG);
			this._launchBG.graphics.beginFill(0xffffff);
			this._launchBG.graphics.drawRect(0, 0, ConstGame.GAME_W, ConstGame.GAME_H);
			this._launchBG.graphics.endFill();
			this._launchBG.addChild(this._launchImg);
			this._launchInterval = flash.utils.setInterval(_clearLaunchImg, 2000);
		}		
		
		private function _clearLaunchImg() : void
		{
			if (_starlingHasInit)
			{
				flash.utils.clearInterval(this._launchInterval);
				this._launchBG.removeChild(this._launchImg);
				this.removeChild(this._launchBG);
				this._launchImg.unloadAndStop(true);
				this._launchImg = null;
				this._launchBG = null;
			}
		}
		
		private function _loaderInfo_completeHandler(event:flash.events.Event):void
		{
			this.loaderInfo.removeEventListener(flash.events.Event.COMPLETE, _loaderInfo_completeHandler);
			ConstGame.GAME_W = this.stage.stageWidth;
			ConstGame.GAME_H = this.stage.stageHeight;
			
			this._showLaunchImg();
			
			var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
			Starling.handleLostContext = !iOS;  
			Starling.multitouchEnabled = false;
			
			_start();
		}
		
		
		private function _start() : void
		{
			this._myStarling = new Starling(Game, this.stage);
			this._myStarling.enableErrorChecking = false;
			this._myStarling.stage.stageWidth = ConstGame.GAME_W;
			this._myStarling.stage.stageHeight = ConstGame.GAME_H;
			
			this._myStarling.start();
//			this._myStarling.stage.color = 0x8ec2f5;
			this._myStarling.addEventListener(starling.events.Event.ROOT_CREATED, _onRootCreated);
			
			this.stage.addEventListener(flash.events.Event.RESIZE, _stage_resizeHandler, false, int.MAX_VALUE, true);
			this.stage.addEventListener(flash.events.Event.DEACTIVATE, _stage_deactivateHandler, false, 0, true);
		}
		
		
		private function _onRootCreated(e:starling.events.Event, game:Game):void
		{
			AssetTool.ins().initTexture("assets/ui/ui_"+ConstGame.LANG, "ui", loadFont);
			
			function loadFont() : void
			{
				AssetTool.ins().initFont("assets/font/num", "my_font", gameStart);
			}
			
			function gameStart() : void
			{
				game.start();
				_starlingHasInit = true;
				_stage_resizeHandler(null);
			}
		}
		
		
		private function _stage_resizeHandler(event:flash.events.Event):void
		{
			ConstGame.GAME_W = this.stage.stageWidth;
			ConstGame.GAME_H = this.stage.stageHeight;
			
			this._myStarling.stage.stageWidth = ConstGame.GAME_W;
			this._myStarling.stage.stageHeight = ConstGame.GAME_H;
			
			const viewPort:Rectangle = this._myStarling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			try
			{
				this._myStarling.viewPort = viewPort;
			}
			catch(error:Error) {}
		}
		
		
		
		private function _stage_deactivateHandler(event:flash.events.Event):void
		{
			this._myStarling.stop();
			this.stage.addEventListener(flash.events.Event.ACTIVATE, _stage_activateHandler, false, 0, true);
		}
		
		private function _stage_activateHandler(event:flash.events.Event):void
		{
			this.stage.removeEventListener(flash.events.Event.ACTIVATE, _stage_activateHandler);
			this._myStarling.start();
		}
		
	}
}