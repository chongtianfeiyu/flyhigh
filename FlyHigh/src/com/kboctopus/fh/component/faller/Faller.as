package com.kboctopus.fh.component.faller
{
	import com.kboctopus.fh.component.Role;
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.tools.AssetTool;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Faller extends Sprite
	{
		private static var rect:Rectangle = new Rectangle();
		private static var m:Matrix = new Matrix();
		protected var icon:Image;
		
		protected var speed:Number;
		private static var minSpeed:Number = 1;
		private static var addSpeed:Number = 2;
		
		protected var ro:Number;
		private static var minRo:Number = -0.1;
		private static var addRo:Number = .2;
		
		public var tBmd:BitmapData;
		public var container:Sprite;
		
		public function Faller()
		{
			super();
			initUI();
		}
		
		public function get bmdName():String
		{
			return "";
		}
		
		
		public function out() : Boolean
		{
			return (this.y>=ConstGame.GAME_H);
		}
		
		
		public function hitRole(role:Role) : Boolean
		{
			var dy:Number = role.y - this.y;
			if (dy > 70 || dy < -114) 
			{
				return false;
			}
			var dx:Number = role.x - this.x;
			if (dx > 70 || dx < -120)
			{
				return false;
			}
			rect = this.getBounds(this.container);
			var offset:Matrix = this.transformationMatrix;
			offset.tx = this.x - rect.x;
			offset.ty = this.y - rect.y;
			tBmd.fillRect(tBmd.rect, 0x00000000);
			tBmd.draw(AssetTool.ins().getAtlas("ui").getBMD(bmdName), offset);
			if (tBmd.hitTest(new Point(rect.x, rect.y), 255, AssetTool.ins().getAtlas("ui").getBMD("octopus"), new Point(role.x, role.y), 255))
			{
				return true;
			}
			return false;
		}
		
		public function get score():int
		{
			return 0;
		}
		
		
		public function move() : void
		{
			this.y += this.speed;
			this.rotation += this.ro;
		}
		
		
		public function reset() : void
		{
			this.y = 0;
			this.x = ConstGame.GAME_W * Math.random();
			this.speed = minSpeed + addSpeed*Math.random();
			this.ro = minRo + addRo*Math.random();
		}
		
		
		protected function initUI():void
		{
			this.icon = new Image(AssetTool.ins().getAtlas("ui").getTexture(bmdName));
			this.addChild(this.icon);
		}

	}
}