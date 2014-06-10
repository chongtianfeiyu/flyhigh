package com.kboctopus.fh.component.faller
{
	public class Hurt_B extends Faller
	{
		public function Hurt_B()
		{
			super();
		}
		
		override public function get bmdName():String
		{
			return "b3";
		}
		
		
		override public function get score():int
		{
			return -6;
		}
	}
}