package com.kboctopus.fh.screen
{
	import com.kboctopus.fh.component.PlayTouchPanel;
	import com.kboctopus.fh.component.Role;
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.tools.AssetTool;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class PlayScreen extends BaseScreen
	{
		private static const FRICTION_VALUE:Number = 10;
		
		private var _bg:Image;
		private var _touchPanel:PlayTouchPanel;
		private var _role:Role;
		
		private var _force:Number = 0;   // 拉力
		private var _friction:Number = 0;  // 摩擦力
		
		public function PlayScreen(manager:IScreenManager)
		{
			super(manager);
		}
		
		
		override protected function initUI():void
		{
			this._role = new Role();
			this._role.x = (ConstGame.GAME_W-this._role.width)>>1;
			this._role.y = 580;
			this.addChild(this._role);
			
			this._touchPanel = new PlayTouchPanel();
			this._touchPanel.y = ConstGame.GAME_H - this._touchPanel.height;
			this.addChild(this._touchPanel);
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
		
		
		private function _onUpdateHandler(e:Event) : void
		{
			if (this._role.vx>0)
			{
				this._friction = 0-FRICTION_VALUE;
			} else if (this._role.vx<0)
			{
				this._friction = FRICTION_VALUE;
			} else {
				this._friction = 0;
			}
			
			var f:Number = this._force+this._friction;
			this._role.vx += f;
			if (this._force==0 && Math.abs(this._role.vx)<f)
			{
				this._role.x += this._role.vx;
				this._role.vx = 0;
			} 
			this._role.x += this._role.vx;
			if (this._role.x < 0)
			{
				this._role.x += ConstGame.GAME_W;
			} else if (this._role.x > ConstGame.GAME_W)
			{
				this._role.x -= ConstGame.GAME_W;
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
					if (touch.globalX > ConstGame.GAME_W*.5)
					{
						this._force = 10 + (touch.globalX-ConstGame.GAME_W*.5)/60;
					} else if (touch.globalX < ConstGame.GAME_W*.5)
					{
						this._force = -10 + (touch.globalX-ConstGame.GAME_W*.5)/60;
					} else 
					{
						this._force = 0;
					}
					trace("force:" + this._force);
					break;
				case TouchPhase.ENDED:
					this._force = 0;
					break;
				default:
					break;
			}
		}
	}
}