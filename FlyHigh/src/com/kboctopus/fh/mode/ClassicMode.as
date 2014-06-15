package com.kboctopus.fh.mode
{
	import com.kboctopus.fh.component.ProgressBar;
	import com.kboctopus.fh.component.Role;
	import com.kboctopus.fh.component.ScoreSP;
	import com.kboctopus.fh.component.faller.*;
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.tools.StaticPool;
	
	import flash.display.BitmapData;
	
	import starling.display.Sprite;

	public class ClassicMode implements IPlayMode
	{
		private var _container:Sprite;
		private var _role:Role;
		private var _score:int;
		private var _rate:int = 30;
		private var _ct:int = 0;
		private var _level:int;
		private var _fazhi:int = 2;
		
		private var _fallers:Vector.<Faller> = new Vector.<Faller>();
		
		private var _tBmd:BitmapData;
		private var _progressBar:ProgressBar;
		
		public function ClassicMode(container:Sprite, role:Role)
		{
			this._tBmd = new BitmapData(70, 70, true);
			this._container = container;
			this._role = role;
			this._progressBar = new ProgressBar();
			this._progressBar.x = this._progressBar.y = 5;
		}
		
		
		public function reset() : void
		{
			this._container.parent.addChild(this._progressBar);
			this._ct = 3600;
			this._progressBar.setProgress(1);
		}
		
		public function clean() : void
		{
			var len:uint = this._fallers.length;
			var faller:Faller;
			while(len--)
			{
				faller = this._fallers.pop();
				this._container.removeChild(faller);
				StaticPool.pushItem(faller);
			}
		}
		
		
		public function create() : void
		{
			var faller:Faller = getRandomFaller();
			faller.tBmd = this._tBmd;
			faller.container = this._container;
			faller.reset();
			this._container.addChild(faller);
			this._fallers.push(faller);
		}
		
		private function getRadomB():Faller
		{
			var r:int = Math.random()*3;
			switch(r)
			{
				case 0:
					return StaticPool.getItem(Stop_B);
					break;
				case 1:
					return StaticPool.getItem(Hurt_B);
					break;
				case 2:
					return StaticPool.getItem(Lighting_B);
					break;
			}
			return StaticPool.getItem(Lighting_B);
		}
		
		private function getRadomG():Faller
		{
			var r:int = Math.random()*5;
			switch(r)
			{
				case 0:
					return StaticPool.getItem(Star_G);
					break;
				case 1:
					return StaticPool.getItem(Fish_G);
					break;
				case 2:
					return StaticPool.getItem(Fllower_G);
					break;
				case 3:
					return StaticPool.getItem(Heart_G);
					break;
				case 4:
					return StaticPool.getItem(Smile_G);
					break;
			}
			return StaticPool.getItem(Smile_G);
		}
		
		
		private function getRandomFaller():Faller
		{
			var r:int = Math.random()*8;
			if (r<=this._fazhi)
			{
				return getRadomB();
			}
			return getRadomG();
		}
		
		
		public function checkOver() : Boolean
		{
			var len:uint = this._fallers.length;
			var f:Faller;
			var sp:ScoreSP;
			for (var i:int=len-1; i>=0; i--)
			{
				f = this._fallers[i];
				if (f.hitRole(this._role))
				{
					score += f.score;
					if (f.score < 0)
					{
						this._role.hurt(f.score);
					}
					sp = StaticPool.getItem(ScoreSP);
					this._container.addChild(sp);
					sp.show(f.score, Faller.rect.x + (Faller.rect.width>>1), Faller.rect.y + (Faller.rect.height>>1));
					this._fallers.splice(i, 1);
					this._container.removeChild(f);
					StaticPool.pushItem(f);
					continue;
				}
				f.move()
			}
			
			_ct--;
			this._progressBar.setProgress(_ct/3600);
			if (_ct <= 0)
			{
				_ct = 3600;
				this._progressBar.removeFromParent();
				return true;
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
			return "classic";
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