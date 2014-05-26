package com.kboctopus.fh.component
{
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.tools.AssetTool;
	
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	
	public class PlayTouchPanel extends Sprite
	{
		private var _bg:QuadBatch;
		private var _rightMask:Image;
		private var _leftMask:Image;
		
		public function PlayTouchPanel()
		{
			_initUI();
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
			
			img = new Image(AssetTool.ins().getAtlas("temp").getTexture("3"));
			img.x = -(img.width*.5);
			this.addChild(img);
			
//			_rightMask
		}
	}
}