package com.kboctopus.fh.component
{
	import com.kboctopus.fh.tools.AssetTool;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class PlayTouchPanel extends Sprite
	{
		private var _bg:Image;
		
		public function PlayTouchPanel()
		{
			_initUI();
		}
		
		
		
		private function _initUI() : void
		{
			this._bg = new Image(AssetTool.ins().getAtlas("temp").getTexture("4"));
			this.addChild(this._bg);
		}
	}
}