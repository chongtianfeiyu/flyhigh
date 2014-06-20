package com.kboctopus.fh.tools
{
	import com.kboctopus.NativeANE;

	public class NativeTool
	{
		private static var _ins:NativeTool;
		
		
		private var _native:NativeANE;
		public function NativeTool()
		{
			this._native = new NativeANE();
		}
		
		
		public static function ins() : NativeTool
		{
			if (_ins == null)
			{
				_ins = new NativeTool();
			}
			return _ins;
		}
		
		
		public function toast(msg:String) : void
		{
			this._native.toast(msg);
		}
		
		
		public function showInputWindow(title:String, callback:Function, btnLab:String="确定", data:String="") : void
		{
			this._native.showInputWindow(title, callback, btnLab, data);
		}
	}
}