package com.kboctopus.fh.component
{
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.tools.AssetTool;
	import com.kboctopus.steer.geom.Vector2D;
	
//	import starling.animation.Transitions;
//	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class PlayTouchPanel extends Sprite
	{
		private var _bg:QuadBatch;
		private var _rightMask:Image;
		private var _leftMask:Image;
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
			
			var img:Image = new Image(AssetTool.ins().getAtlas("temp").getTexture("2_1"));
			var imgW:Number = img.width;
			var beginX:Number = 0;
			while (this._bg.width < ConstGame.GAME_W)
			{
				img.x = beginX;
				img.scaleX = 1;
				this._bg.addImage(img);
				
				img.x = -beginX;
				img.scaleX = -1;
				this._bg.addImage(img);
				
				beginX += imgW;
			}
			
			
			this._rightMask = new Image(AssetTool.ins().getAtlas("temp").getTexture("6_1"));
			this._leftMask = new Image(AssetTool.ins().getAtlas("temp").getTexture("6_2"));
			this._leftMask.pivotX = 4
			this._leftMask.x = 0;
			this.addChild(this._rightMask);
			this.addChild(this._leftMask);
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
					img = dis > 0 ? this._rightMask : this._leftMask;
					this._role.setForceDic(this.force.x);
//					Starling.juggler.tween(img, .2, {
////						transition: Transitions.EASE_IN,
//						width: Math.abs(dis)
//					});
					break;
				case TouchPhase.ENDED:
					this.force.x = 0;
					this._role.setForceDic(this.force.x);
//					Starling.juggler.tween(this._rightMask, .2, {
////						transition: Transitions.EASE_IN,
//						width: 4
//					});
//					Starling.juggler.tween(this._leftMask, .2, {
////						transition: Transitions.EASE_IN,
//						width: 4
//					});
					break;
				default:
					break;
			}
		}
	}
}