package com.kboctopus.fh.component
{
	import com.kboctopus.fh.tools.AssetTool;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Baffle extends Sprite
	{
		public function Baffle()
		{
			_initUI();
		}
		
		
		private function _initUI() : void
		{
			var img:Image = new Image(AssetTool.ins().getAtlas("temp").getTexture("8"));
			this.addChild(img);
			img = new Image(AssetTool.ins().getAtlas("temp").getTexture("8"));
			img.x = img.width + 120;
			this.addChild(img);
		}
		
		
		
		public function reset() : void
		{
			this.y = -80;
			this.x = -Math.random()*360-120;
		}
		
		
		public function move() : void
		{
			this.y += 1.5;
		}
		
		
		public function out() : Boolean
		{
			return (this.y>=800);
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
			if (disX>=480 && disX<=600)
			{
				return false;
			}
			return true;
		}
	}
}