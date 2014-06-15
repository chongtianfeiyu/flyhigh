package com.kboctopus.fh.mode
{
	import com.kboctopus.fh.component.Baffle;
	import com.kboctopus.fh.component.Role;
	import com.kboctopus.fh.consts.ConstGame;
	
	import starling.display.Sprite;
	
	public class EasyMode extends HardMode
	{
		public function EasyMode(container:Sprite, role:Role)
		{
			super(container, role);
		}
		
		override public function reset() : void
		{
			Baffle.setDistanceBetweenUnit(160);
		}
		
		override public function get modeName() : String
		{
			return "easy";
		}
	}
}