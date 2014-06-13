package com.kboctopus.fh.component
{
	import com.kboctopus.fh.consts.ConstGame;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import starling.core.Starling;
	
	public class FirstTip extends Sprite
	{
		private var _ldr:Loader;
		
		public var clickHandler:Function;
		
		public function FirstTip()
		{
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(0, 0, ConstGame.GAME_W, ConstGame.GAME_H);
			this.graphics.endFill();
			
			this._ldr = new Loader();
			this._ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			this._ldr.load(new URLRequest("assets/ui/first_tip.png"));
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, onDownHandler);
		}
		
		protected function onDownHandler(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onDownHandler);
			Starling.current.nativeStage.removeChild(this);
			clickHandler();
		}
		
		protected function loadComplete(event:Event):void
		{
			this._ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
			
			this._ldr.mouseEnabled = false;
			this.addChild(this._ldr);
			this._ldr.x = (ConstGame.GAME_W-_ldr.width)>>1;
			this._ldr.y = (ConstGame.GAME_H-_ldr.height)>>1;
		}
	}
}