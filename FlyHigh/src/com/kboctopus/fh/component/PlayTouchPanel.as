package com.kboctopus.fh.component
{
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.tools.AssetTool;
	import com.kboctopus.steer.geom.Vector2D;
	
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class PlayTouchPanel extends Sprite
	{
		private var _bg:QuadBatch;
		private var _role:Role;
		public var force:Vector2D;
		private var _halfSW:int;
		
		public function PlayTouchPanel(r:Role)
		{
			this.force = new Vector2D();
			this._role = r;
			this._halfSW = ConstGame.GAME_W>>1;
			_initUI();
			initEvent();
		}
		
		
		public function initEvent() : void
		{
			this.addEventListener(TouchEvent.TOUCH, _onTouchPanelHandler);
		}
		
		
		public function removeEvent() : void
		{
			this.removeEventListener(TouchEvent.TOUCH, _onTouchPanelHandler);
		}
		
		
		
		private function _initUI() : void
		{
			var halfW:Number = ConstGame.GAME_W*05;
			
			this._bg = new QuadBatch();
			this.addChild(this._bg);
			
			var img:Image = new Image(AssetTool.ins().getAtlas("ui").getTexture("control"));
			img.x = -240;
			this._bg.addImage(img);
			var beginX:Number = 240;
			var imgLeft:Image = new Image(AssetTool.ins().getAtlas("ui").getTexture("control_left"));
			var imgRight:Image = new Image(AssetTool.ins().getAtlas("ui").getTexture("control_right"));
			while (this._bg.width < ConstGame.GAME_W)
			{
				imgRight.x = beginX;
				this._bg.addImage(imgRight);
				
				imgLeft.x = -beginX;
				this._bg.addImage(imgLeft);
				
				beginX+=55;
			}
		}
		
		
		
		private function _onTouchPanelHandler(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this);
			if (touch == null)
			{
				return;
			}
			
			var img:Image;
			var dis:Number;
			switch(touch.phase) 
			{
				case TouchPhase.BEGAN:
					dis = touch.globalX-this._halfSW;
					this.force.x = dis/12;
					this._role.setForceDic(this.force.x);
					break;
				case TouchPhase.ENDED:
					this.force.x = 0;
					this._role.setForceDic(this.force.x);
					break;
				default:
					break;
			}
		}
	}
}