package com.kboctopus.fh.tools
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;

	public class AssetTool
	{
		private var _assetManager:AssetManager;
		private var _ldr:Loader;
		private var _uldr:URLLoader;
		private var _path:String;
		private var _atlasDic:Dictionary;
		private var _tmpName:String;
		private var _callback:Function;
		
		private static var _ins:AssetTool;
		
		public function AssetTool(single:Single)
		{
			if (null==single)
			{
				throw new IllegalOperationError("please use ins() to get the instance!");
			}
			
			this._assetManager = new AssetManager();
			this._atlasDic = new Dictionary();
			this._ldr = new Loader();
			this._uldr = new URLLoader();
			this._ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, _loadImgComplete);
			this._uldr.addEventListener(Event.COMPLETE, _loadXmlComplete);
		}
		
		
		private function _loadImgComplete(event:Event):void
		{
			this._uldr.load(new URLRequest(this._path+".xml"));
		}		
		
		
		private function _loadXmlComplete(event:Event):void
		{
			this._atlasDic[this._tmpName] = new TextureAtlas(Texture.fromBitmap(this._ldr.content as Bitmap), XML(this._uldr.data));
			this._callback();
		}
		
		
		public static function ins() : AssetTool
		{
			if (null==_ins)
			{
				_ins = new AssetTool(new Single());
			}
			return _ins;
		}
		
		
		public function getAtlas(name:String) : TextureAtlas
		{
			return this._atlasDic[name] as TextureAtlas;
		}
		
		
		public function loadPath(path:String, name:String, callback:Function) : void
		{
			this._callback = callback;
			this._tmpName = name;
			this._path = path;
			this._ldr.load(new URLRequest(this._path+".png"));
		}
	}
}


class Single{}