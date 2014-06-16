package com.kboctopus.fh.component
{
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.tools.AssetTool;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	
	public class Baffle extends Sprite
	{
		private var unit1:QuadBatch;
		private var unit2:QuadBatch;
		
		private static var qbWidth:Number = 0;
		private static var disBetweenUnit:Number = 0;
		private static var hasInit:Boolean = false;
		private static var _leftPoints:Vector.<Point> = new Vector.<Point>();
		private static var _rightPoints:Vector.<Point> = new Vector.<Point>();
		private static var _rightPointsBak:Vector.<Point> = new Vector.<Point>();
		
		public function Baffle()
		{
			_initUI();
		}
		
		
		public static function setDistanceBetweenUnit(dis:Number) : void
		{
			disBetweenUnit = dis;
			var len:int = _rightPointsBak.length;
			for (var i:int=0; i<len; i++)
			{
				_rightPoints[i].x = _rightPointsBak[i].x + disBetweenUnit;
			}
		}
		
		
		private static function initStatic(minW:Number) : void
		{
			var point:Point = new Point(qbWidth, 8);
			_leftPoints.push(point);
			_rightPoints.push(point.clone());
			_rightPointsBak.push(point.clone());
			point = new Point(qbWidth, 72);
			_leftPoints.push(point);
			_rightPoints.push(point.clone());
			_rightPointsBak.push(point.clone());
			point = new Point(qbWidth, 40);
			_leftPoints.push(point);
			_rightPoints.push(point.clone());
			_rightPointsBak.push(point.clone());
			var num:int = qbWidth/minW;
			var x1:Number = minW*.5;
			point = new Point(qbWidth-x1, 80);
			_leftPoints.push(point);
			point = new Point(qbWidth+x1, 80);
			_rightPoints.push(point);
			_rightPointsBak.push(point.clone());
			while(num--)
			{
				x1 += minW;
				point = new Point(qbWidth-x1, 80);
				_leftPoints.push(point);
				point = new Point(qbWidth+x1, 80);
				_rightPoints.push(point);
				_rightPointsBak.push(point.clone());
			}
		}
		
		
		private function _initUI() : void
		{
			unit1 = new QuadBatch();
			var img:Image = new Image(AssetTool.ins().getAtlas("ui").getTexture("baffle_unit"));
			unit1.addImage(img);
			while (unit1.width<ConstGame.GAME_W)
			{
				img.x = unit1.width-1;
				unit1.addImage(img);
			}
			
			if (!hasInit)
			{
				hasInit = true;
				qbWidth = unit1.width;
				initStatic(img.width-1);
			}
			
			unit1.x = 0;
			unit2 = unit1.clone();
			this.addChild(unit1);
			this.addChild(unit2);
			this.touchable = false;
		}
		
		
		
		public function reset() : void
		{
			this.y = -80;
			this.unit2.x = qbWidth + disBetweenUnit;
			this.x = -qbWidth + Math.random()*(ConstGame.GAME_W-disBetweenUnit);
		}
		
		
		public function move(v:Number) : void
		{
			this.y += v;
		}
		
		
		public function out() : Boolean
		{
			return (this.y>=ConstGame.GAME_H);
		}
		
		
		public function hitRole(role:Role) : Boolean
		{
			var lx:Number;
			var ly:Number;
			var dx:Number;
			var dy:Number;
			for each(var point:Point in _leftPoints)
			{
				lx = this.x + point.x;
				ly = this.y + point.y;
				dx = lx - (role.x+25);
				dy = ly - (role.y+22);
				if (dx*dx + dy*dy < 530)
				{
					return true;
				}
			}
			
			for each(point in _rightPoints)
			{
				lx = this.x + point.x;
				ly = this.y + point.y;
				dx = lx - (role.x+25);
				dy = ly - (role.y+22);
				if (dx*dx + dy*dy < 530)
				{
					return true;
				}
			}
			return false;
		}
	}
}