package com.kboctopus.fh.component.faller
{
	public class Stop_B extends Faller
	{
		public function Stop_B()
		{
			super();
		}
		
		override public function get bmdName():String
		{
			return "b1";
		}
		
		
		override public function get score():int
		{
			return -2;
		}
	}
}