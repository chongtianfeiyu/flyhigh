package com.kboctopus.fh.mode
{
	public interface IPlayMode
	{
		function checkOver() : Boolean;
		function clean() : void;
		function create() : void;
		
		function set score(value:int):void;
		function get score():int;
		
		
		function get rate():int
	}
}