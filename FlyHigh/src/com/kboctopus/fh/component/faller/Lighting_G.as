package com.kboctopus.fh.component.faller
{
	public class Lighting_G extends Faller
	{
		public function Lighting_G()
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