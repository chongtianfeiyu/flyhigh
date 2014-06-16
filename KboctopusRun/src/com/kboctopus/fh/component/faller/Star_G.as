package com.kboctopus.fh.component.faller
{
	import com.kboctopus.fh.tools.AssetTool;
	
	import starling.display.Image;

	public class Star_G extends Faller
	{
		public function Star_G()
		{
			super();
		}
		
		override public function get bmdName():String
		{
			return "g1";
		}
		
		
		override public function get score():int
		{
			return 1;
		}
	}
}