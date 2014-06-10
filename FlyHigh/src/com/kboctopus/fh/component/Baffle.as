package com.kboctopus.fh.component
{
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.tools.AssetTool;
	
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	
	public class Baffle extends Sprite
	{
		private var uint:QuadBatch;
		
		private static var qbWidth:Number = 0;
		private static var hasInit:Boolean = false;
		private static var points:Array = [];
		
		public function Baffle()
		{
			_initUI();
		}
		
		private static function initStatic(wid:Number, minW:Number) : void
		{
			hasInit = true;
			
			qbWidth = wid;
			var point:Point = new Point(qbWidth, 8);
			points.push(point);
			point = new Point(qbWidth, 72);
			points.push(point);
			point = new Point(qbWidth+120, 8);
			points.push(point);
			point = new Point(qbWidth+120, 72);
			points.push(point);
			point = new Point(qbWidth, 40);
			points.push(point);
			point = new Point(qbWidth+120, 40);
			points.push(point);
			var num:int = wid/minW;
			var x1:Number = minW*.5;
			point = new Point(qbWidth-x1, 80);
			points.push(point);
			point = new Point(qbWidth+120+x1, 80);
			points.push(point);
			while(num--)
			{
				x1 += minW;
				point = new Point(qbWidth-x1, 80);
				points.push(point);
				point = new Point(qbWidth+120+x1, 80);
				points.push(point);
			}
		}
		
		
		private function _initUI() : void
		{
			uint = new QuadBatch();
			var img:Image = new Image(AssetTool.ins().getAtlas("ui").getTexture("baffle_unit"));
			uint.addImage(img);
			
			while (uint.width<ConstGame.GAME_W)
			{
				img.x = uint.width-1;
				uint.addImage(img);
			}
			
			if (!hasInit)
			{
				initStatic(uint.width, img.width-1);
			}
			
			var qb2:QuadBatch = new QuadBatch();
			this.addChild(qb2);
			uint.x = 0;
			qb2.addQuadBatch(uint);
			uint.x = qbWidth + 120;
			qb2.addQuadBatch(uint);
			
			this.touchable = false;
		}
		
		
		
		public function reset() : void
		{
			this.y = -80;
			this.x = -qbWidth + Math.random()*(ConstGame.GAME_W-120);
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
			for each(var point:Point in points)
			{
				var lx:Number = this.x + point.x;
				var ly:Number = this.y + point.y;
				var dx:Number = lx - (role.x+25);
				var dy:Number = ly - (role.y+22);
				if (dx*dx + dy*dy < 530)
				{
					return true;
				}
			}
			return false;
		}
	}
}