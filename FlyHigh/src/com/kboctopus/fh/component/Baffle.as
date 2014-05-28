package com.kboctopus.fh.component
{
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.tools.AssetTool;
	
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	
	public class Baffle extends Sprite
	{
		private var qbWidth:Number = 0;
		
		public function Baffle()
		{
			_initUI();
		}
		
		
		private function _initUI() : void
		{
			var qb:QuadBatch = new QuadBatch();
			var img:Image = new Image(AssetTool.ins().getAtlas("temp").getTexture("5_1"));
			qb.addImage(img);
			
			img = new Image(AssetTool.ins().getAtlas("temp").getTexture("5_2"));
			while (qb.width<ConstGame.GAME_W)
			{
				img.x = qb.width;
				qb.addImage(img);
			}
			
			img = new Image(AssetTool.ins().getAtlas("temp").getTexture("5_3"));
			img.x = qb.width;
			qb.addImage(img);
			
			qbWidth = qb.width;
			var qb2:QuadBatch = new QuadBatch();
			this.addChild(qb2);
			qb2.addQuadBatch(qb);
			qb.x = qbWidth + 120;
			qb2.addQuadBatch(qb);
			
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
			return (this.y>=ConstGame.GAME_H-160);
		}
		
		
		public function hitRole(role:Role) : Boolean
		{
			if (this.y+80 < role.y)
			{
				return false;
			}
			if (this.y > role.y+40)
			{
				return false;
			}
			var disX:Number = role.x-this.x;
			if (disX>=qbWidth && disX<=qbWidth+80)
			{
				return false;
			}
			return true;
		}
	}
}