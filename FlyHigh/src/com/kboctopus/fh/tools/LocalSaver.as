package com.kboctopus.fh.tools
{
	import flash.net.SharedObject;

	public class LocalSaver
	{
		private static var _ins:LocalSaver;
		
		private var _so:SharedObject;
		public function LocalSaver()
		{
			_so = SharedObject.getLocal("flyHigh");
		}
		
		
		public static function ins():LocalSaver
		{
			if (_ins == null)
			{
				_ins = new LocalSaver();
			}
			return _ins;
		}
		
		
		public function get so() : SharedObject
		{
			return _so;
		}
	}
}