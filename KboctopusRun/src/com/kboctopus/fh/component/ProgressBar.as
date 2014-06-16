package com.kboctopus.fh.component
{
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.tools.AssetTool;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class ProgressBar extends Sprite
	{
		private var _bg:Image;
		private var _bar:Image;
		private var _w:Number;
		
		public function ProgressBar()
		{
			_initUI();
		}
		
		
		private function _initUI() : void
		{
			_w = ConstGame.GAME_W-10;
			
			this._bar = new Image(AssetTool.ins().getAtlas("ui").getTexture("progress_core"));
			this.addChild(this._bar);
			this._bg = new Image(AssetTool.ins().getAtlas("ui").getTexture("progress_bg"));
			this.addChild(this._bg);
			this._bg.width = _w;
			
			this.touchable = false;
		}
		
		
		public function setProgress(rate:Number) : void
		{
			this._bar.width = _w * rate;
		}
	}
}