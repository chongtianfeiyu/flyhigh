package com.kboctopus.fh.component
{
	import com.kboctopus.fh.tools.AssetTool;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Role extends Sprite
	{
		private var _icon:Image;
		public var vx:Number = 0;
		public var vy:Number = 0;
		
		public function Role()
		{
			_initUI();
		}
		
		
		private function _initUI() : void
		{
			this._icon = new Image(AssetTool.ins().getAtlas("temp").getTexture("1"));
			this.addChild(this._icon);
		}
	}
}