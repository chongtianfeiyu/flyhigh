package com.kboctopus.fh.component
{
	import com.kboctopus.fh.tools.AssetTool;
	import com.kboctopus.steer.geom.Vector2D;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Role extends Sprite
	{
		private var _icon:Image;
		
		private var _mass:Number = 20;
		private var _position:Vector2D;  // 当前位置
		private var _velocity:Vector2D;  // 加速度
		private var _maxSpeed:Number = 30;  // 最高速
		private var _force:Vector2D;  // 外部作用力
		
		public function Role()
		{
			this._position = new Vector2D();
			this._velocity = new Vector2D();
			this._force = new Vector2D();
			_initUI();
		}
		
		
		private function _initUI() : void
		{
			this._icon = new Image(AssetTool.ins().getAtlas("temp").getTexture("1"));
			this.addChild(this._icon);
		}
		
		
		
		public function applyForces(...args) : void
		{
			var len:int = args.length;
			for (var i:int=0; i<len; i++)
			{
				this._force = this._force.add(args[i]);
			}
		}
		
		
		public function move() : void
		{
			this._velocity = this._velocity.add(this._force.divide(this._mass));
			this._force = new Vector2D();
			this._velocity.truncate(this._maxSpeed);
			this.position = this._position.add(this._velocity);
		}
		
		
		public function get velocity():Vector2D
		{
			return _velocity;
		}
		
		
		public function set position(value:Vector2D):void
		{
			_position = value;
			x = _position.x;
			y = _position.y;
		}
		
		override public function set x(value:Number):void
		{
			super.x = value;
			_position.x = x;
		}
		
		override public function set y(value:Number):void
		{
			super.y = value;
			_position.y = y;
		}
	}
}