package com.kboctopus.fh.mode
{
	import starling.extensions.PDParticleSystem;

	public interface IPlayMode
	{
		function checkOver() : Boolean;
		function clean() : void;
		function create() : void;
		
		function setParticles(b:PDParticleSystem, g:PDParticleSystem) : void;
		
		function get level():int;
		function set level(value:int):void;
		
		function set score(value:int):void;
		function get score():int;
		
		
		function get rate():int;
	}
}