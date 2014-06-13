package com.kboctopus.fh.component.faller
{
	public class Lighting_B extends Faller
	{
		public function Lighting_B()
		{
			super();
		}
		
		override public function get bmdName():String
		{
			return "b2";
		}
		
		
		override public function get score():int
		{
			return -4;
		}
	}
}