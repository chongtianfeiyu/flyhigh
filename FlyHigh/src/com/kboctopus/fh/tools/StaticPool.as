package com.kboctopus.fh.tools
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class StaticPool
	{
		private static var dic:Dictionary = new Dictionary();
		
		public static function clear(itemType:*):void
		{
			dic[itemType] = null;
			delete dic[itemType];
		}
		
		public static function getItem(itemType:*):*
		{
			var className:String = getQualifiedClassName(itemType);
			if(dic[className] != null && dic[className].length > 0) 
				return dic[className].pop();
			
			var ClassRef:Class = getDefinitionByName(className)as Class;
			return new ClassRef();
		}
		
		
		public static function pushItem(item:*):void
		{
			var className:String = getQualifiedClassName(item);
			if(dic[className] == null) 
				dic[className] = [];
			
			dic[className].push(item);
		}
	}
}