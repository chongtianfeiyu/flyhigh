package
{
	import com.kboctopus.fh.Game;
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.tools.AssetTool;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.events.Event;
	import flash.geom.Rectangle;
	
	[SWF(width="480", height="800", frameRate="60")]
	public class FlyHigh extends Sprite
	{
		private var _myStarling:Starling;
		private var _launchImg:Loader;
		
		public function FlyHigh()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			this.mouseEnabled = this.mouseChildren = false;
			this._showLaunchImg();
			this.loaderInfo.addEventListener(flash.events.Event.COMPLETE, _loaderInfo_completeHandler);
		}
		
		
		private function _showLaunchImg() : void
		{
		}
		
		
		private function _loaderInfo_completeHandler(event:flash.events.Event):void
		{
			ConstGame.GAME_W = 480;
			ConstGame.GAME_H = 800;
			
			var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
			Starling.handleLostContext = !iOS;  
			Starling.multitouchEnabled = false;
			
			_start();
		}
		
		
		private function _start() : void
		{
			this._myStarling = new Starling(Game, this.stage);
			this._myStarling.enableErrorChecking = false;
			
			this._myStarling.start();
//			this._myStarling.stage.color = 0x8ec2f5;
			this._myStarling.addEventListener(starling.events.Event.ROOT_CREATED, _onRootCreated);
			
			this.stage.addEventListener(flash.events.Event.RESIZE, _stage_resizeHandler, false, int.MAX_VALUE, true);
			this.stage.addEventListener(flash.events.Event.DEACTIVATE, _stage_deactivateHandler, false, 0, true);
		}
		
		
		private function _onRootCreated(e:starling.events.Event, game:Game):void
		{
			AssetTool.ins().loadPath("assets/ui/temp", "temp", gameStart);
		
			function gameStart() : void
			{
				game.start();
				if(_launchImg)
				{
					removeChild(_launchImg);
					_launchImg.unloadAndStop(true);
					_launchImg = null;
				}
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