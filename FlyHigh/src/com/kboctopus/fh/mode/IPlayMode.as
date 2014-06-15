package com.kboctopus.fh.mode
{
	public interface IPlayMode
	{
		function checkOver() : Boolean;
		function checkRole() : void;
		function clean() : void;
		function create() : void;
		function reset() : void;
		
		function get modeName() : String;
		
		function get rate():int;
		
		function set score(value:int):void;
		function get score():int;
		
		
	}
}