package com.kboctopus.fh.mode
{
	import com.kboctopus.fh.component.Baffle;
	import com.kboctopus.fh.component.Role;
	
	import starling.display.Sprite;

	public class ZenMode implements IPlayMode
	{
		private var _speed:Number = 3;
		
		private var _showBaffle:Vector.<Baffle> = new Vector.<Baffle>();
		private var _poolBaffle:Vector.<Baffle> = new Vector.<Baffle>();
		
		private var _container:Sprite;
		private var _role:Role;
		private var _score:int;
		private var _rate:int = 100;
		
		public function ZenMode(container:Sprite, role:Role)
		{
			this._container = container;
			this._role = role;
		}
		
		
		public function clean() : void
		{
			var len:uint = this._showBaffle.length;
			var b:Baffle;
			while(len--)
			{
				b = this._showBaffle.pop();
				this._container.removeChild(b);
				this._poolBaffle.push(b);
			}
		}
		
		
		public function create() : void
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
			this._container.addChild(baffle);
			this._showBaffle.push(baffle);
		}
		
		
		public function checkOver() : Boolean
		{
			for each(var b:Baffle in this._showBaffle)
			{
				if (b.hitRole(this._role))
				{
					return true;
				}
				
				b.move(_speed);
				if (b.out())
				{
					this.score = this._score + 1;
					this._container.removeChild(b);
					this._poolBaffle.push(this._showBaffle.shift());
				}
			}
			return false;
		}
		
		
		public function set score(value:int):void
		{
			_score = value;
		}
		public function get score():int
		{
			return this._score;
		}

		public function get rate():int
		{
			return _rate;
		}
		private function set rate(value:int):void
		{
			_rate = value;
		}
		
	}
}