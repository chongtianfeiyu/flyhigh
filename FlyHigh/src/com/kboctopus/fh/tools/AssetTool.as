package com.kboctopus.fh.tools
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import starling.extensions.PDParticleSystem;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class AssetTool
	{
		private static const TYPE_IMG:int = 0;
		private static const TYPE_FONT:int = 1;
		private static const TYPE_PARTICLE:int = 2;
		
		private var _assetManager:AssetManager;
		private var _ldr:Loader;
		private var _uldr:URLLoader;
		private var _path:String;
		private var _atlasDic:Dictionary;
		private var _particleDic:Dictionary;
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
			this._particleDic = new Dictionary();
			this._ldr = new Loader();
			this._uldr = new URLLoader();
			this._ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, _loadComplete);
			this._uldr.addEventListener(Event.COMPLETE, _loadXmlComplete);
		}
		
		
		private function _loadComplete(event:Event):void
		{
			switch (this._type)
			{
				case TYPE_IMG:
					this._uldr.load(new URLRequest(this._path+".xml"));
					break;
				case TYPE_FONT:
					this._uldr.load(new URLRequest(this._path+".fnt"));
					break;
				case TYPE_PARTICLE:
					this._uldr.load(new URLRequest(this._path+".pex"));
					break;
			}
		}		
		
		
		private function _loadXmlComplete(event:Event):void
		{
			switch (this._type)
			{
				case TYPE_IMG:
					this._atlasDic[this._tmpName] = new MyTextureAtlas(this._ldr.content as Bitmap, XML(this._uldr.data));
					break;
				case TYPE_FONT:
					TextField.registerBitmapFont(new BitmapFont(Texture.fromBitmap(this._ldr.content as Bitmap), XML(this._uldr.data)), this._tmpName);
					break;
				case TYPE_PARTICLE:
					this._particleDic[this._tmpName] = new PDParticleSystem(XML(this._uldr.data), Texture.fromBitmap(this._ldr.content as Bitmap));
					break;
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
		
		
		public function getAtlas(name:String) : MyTextureAtlas
		{
			return (this._atlasDic[name] as MyTextureAtlas);
		}
		
		
		public function getParticle(name:String) : PDParticleSystem
		{
			return this._particleDic[name] as PDParticleSystem;
		}
		
		
		public function initTexture(path:String, name:String, callback:Function) : void
		{
			this._type = TYPE_IMG;
			_loadSource(path, name, callback);
		}
		
		
		public function initFont(path:String, name:String, callback:Function) : void
		{
			this._type = TYPE_FONT;
			_loadSource(path, name, callback);
		}
		
		
		public function initParticle(path:String, name:String, callback:Function) : void
		{
			this._type = TYPE_PARTICLE;
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