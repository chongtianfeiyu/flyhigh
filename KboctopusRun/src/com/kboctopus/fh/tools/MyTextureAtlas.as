package com.kboctopus.fh.tools
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class MyTextureAtlas extends TextureAtlas
	{
		private var _bmdDic:Dictionary = new Dictionary();
		
		public function MyTextureAtlas(bitmap:Bitmap, atlasXml:XML=null)
		{
			super(Texture.fromBitmap(bitmap), atlasXml);
			this.parseBMDXml(bitmap.bitmapData, atlasXml);
		}
		
		
		protected function parseBMDXml(sbmd:BitmapData, atlasXml:XML):void
		{
			var bmd:BitmapData;
			var m:Matrix = new Matrix();
			for each (var subTexture:XML in atlasXml.SubTexture)
			{
				var name:String        = subTexture.attribute("name");
				if (name=="g1" || name=="g2" || name=="g3" || name=="g4" ||
					name=="g5" || name=="b1" || name=="b2" || name=="b3" ||
					name=="octopus")
				{
					var x:Number           = parseFloat(subTexture.attribute("x"));
					var y:Number           = parseFloat(subTexture.attribute("y"));
					var width:Number       = parseFloat(subTexture.attribute("width"));
					var height:Number      = parseFloat(subTexture.attribute("height"));
					
					bmd = new BitmapData(width, height, true, 0);
					m.translate(-x, -y);
					bmd.draw(sbmd.clone(), m);
					_bmdDic[name] = bmd;
					m.translate(x, y);
				}
			}
		}
		
		
		public function getBMD(name:String) : BitmapData
		{
			return _bmdDic[name];
		}
	}
}