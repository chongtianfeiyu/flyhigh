package com.kboctopus.fh.mode
{
	import com.gamua.flox.Flox;
	import com.gamua.flox.TimeScope;
	import com.kboctopus.fh.component.Baffle;
	import com.kboctopus.fh.component.Role;
	import com.kboctopus.fh.consts.ConstGame;
	
	import starling.display.Sprite;

	public class HardMode implements IPlayMode
	{
		protected var _speed:Number = 3;
		protected var _rate:int = 100;
		
		private var _showBaffle:Vector.<Baffle> = new Vector.<Baffle>();
		private var _poolBaffle:Vector.<Baffle> = new Vector.<Baffle>();
		
		private var _container:Sprite;
		private var _role:Role;
		private var _score:int;
		
		protected var _leaderboards:Array;
		protected var _canBePutBoard:Boolean = true;
		
		public function HardMode(container:Sprite, role:Role)
		{
			this._container = container;
			this._role = role;
			this._rate = ConstGame.GAME_W*100/480;
			
			Flox.loadScores(this.modeName, TimeScope.THIS_WEEK, 
				function onComplete(scores:Array):void {
					_leaderboards = scores;
					_canBePutBoard = true;
				},
				function onError(error:String):void {
					_canBePutBoard = false;
				}
			);
		}
		
		
		public function reset() : void
		{
			Baffle.setDistanceBetweenUnit(120);
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
		
		
		public function checkPutToBoard():void
		{
			if (!this._canBePutBoard)
			{
				return;
			}
			if (this._leaderboards == null)
			{
				this._leaderboards = [];
				Flox.postScore(this.modeName, this.score, "p");
			}
			else
			{
				var len:int = this._leaderboards.length;
				var index:int;
				if (len > 10)
				{
					index = 10;
				} 
				else
				{
					index = len-1;
				}
				if (this._leaderboards[index]<this.score)
				{
					Flox.postScore(this.modeName, this.score, "p");
				}
			}
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
		
		public function checkRole() : void
		{
			if (this._role.x < 0)
			{
				this._role.x += ConstGame.GAME_W;
			} else if (this._role.x > ConstGame.GAME_W)
			{
				this._role.x -= ConstGame.GAME_W;
			}
		}
		
		public function get modeName() : String
		{
			return "hard";
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
		
		public function get leaderboards() : Array
		{
			return _leaderboards;
		}
		public function get canBePutBoard():Boolean
		{
			return _canBePutBoard;
		}
	}
}