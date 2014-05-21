package com.kboctopus.fh.tools
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;

	public class AssetTool
	{
		private static const TYPE_IMG:int = 0;
		private static const TYPE_FONT:int = 1;
		
		private var _assetManager:AssetManager;
		private var _ldr:Loader;
		private var _uldr:URLLoader;
		private var _path:String;
		private var _atlasDic:Dictionary;
		private var _tmpName:String;
		private var _callback:Function;
		
		private var _type:int;
		
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
			this._ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, _loadComplete);
			this._uldr.addEventListener(Event.COMPLETE, _loadXmlComplete);
		}
		
		
		private function _loadComplete(event:Event):void
		{
			if (this._type == TYPE_IMG)
			{
				this._uldr.load(new URLRequest(this._path+".xml"));
			}
			else
			{
				this._uldr.load(new URLRequest(this._path+".fnt"));
			}
		}		
		
		
		private function _loadXmlComplete(event:Event):void
		{
			if (this._type == TYPE_IMG)
			{
				this._atlasDic[this._tmpName] = new TextureAtlas(Texture.fromBitmap(this._ldr.content as Bitmap), XML(this._uldr.data));
			}
			else
			{
				TextField.registerBitmapFont(new BitmapFont(Texture.fromBitmap(this._ldr.content as Bitmap), XML(this._uldr.data)), this._tmpName);
			}
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
		
		
		public function loadImg(path:String, name:String, callback:Function) : void
		{
			this._type = TYPE_IMG;
			_loadSource(path, name, callback);
		}
		
		
		public function initFont(path:String, name:String, callback:Function) : void
		{
			this._type = TYPE_FONT;
			_loadSource(path, name, callback);
		}
		
		
		private function _loadSource(path:String, name:String, callback:Function) : void
		{
			this._callback = callback;
			this._tmpName = name;
			this._path = path;
			this._ldr.load(new URLRequest(this._path+".png"));
		}
	}
}


class Single{}