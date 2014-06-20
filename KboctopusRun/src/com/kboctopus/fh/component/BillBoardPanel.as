package com.kboctopus.fh.component
{
	import com.kboctopus.NativeANE;
	import com.kboctopus.fh.consts.ConstGame;
	import com.kboctopus.fh.mode.IPlayMode;
	import com.kboctopus.fh.tools.JPGEncoder;
	import com.kboctopus.fh.tools.MyString;
	import com.kboctopus.sns.ServiceManager;
	import com.kboctopus.sns.constant.ServiceType;
	
	import flash.display.BitmapData;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class BillBoardPanel extends Sprite
	{
		private var _bg:Image;
		private var _modeImg:Image;
		private var _closeBtn:MyButton;
		private var _tops:Vector.<TextField>;
		private var _mtBestScoreTF:TextField;
		private var _snsTencent:MyButton;
		private var _snsSina:MyButton;
		
		private var _shareBMD:BitmapData;
		private var _currentPlatForm:String;
		
		private var _native:NativeANE;
		private var _clickAble:Boolean = true;
		
		public function BillBoardPanel()
		{
			super();
			_initUI();
		}
		
		
		private function _initUI() : void
		{
			this._bg = new Image(null);
			this.addChild(this._bg);
			
			this._modeImg = new Image(null);
			this.addChild(this._modeImg);
			
			this._closeBtn = new MyButton("", _closeMe);
			this.addChild(this._closeBtn);
			
			this._snsSina = new MyButton("share_sina", _shareSina);
			this._snsTencent = new MyButton("share_tencent", _shareTencent);
			this.addChild(this._snsTencent);
			this.addChild(this._snsSina);
			
			//init tf
			this._tops = new Vector.<TextField>();
			var tf:TextField;
			for (var i:int=0; i<5; i++)
			{
				tf = new TextField(100, 40, "my_font");
				this.addChild(tf);
				tf.x = 100;
				tf.y = 100;
				tf.touchable = false;
				this._tops.push(tf);
			}
			
			
			this._shareBMD = new BitmapData(ConstGame.GAME_W, ConstGame.GAME_H, false);
			this._native = new NativeANE();
		}
		
		
		private function _shareSina(v:MyButton) : void
		{
			_currentPlatForm = ServiceType.SINA;
			ServiceManager.ins().auth(_currentPlatForm, _authComplete);
		}
		
		
		private function _shareTencent(v:MyButton) : void
		{
			_currentPlatForm = ServiceType.TENCENT;
			ServiceManager.ins().auth(_currentPlatForm, _authComplete);
		}
		
		private function _authComplete(result:String):void
		{
			this._native.showInputWindow(MyString.share_title, _readyToShare, MyString.btn_ok, MyString.share_text);
		}
		
		
		private function _readyToShare(text:String):void
		{
			this.stage.drawToBitmapData(this._shareBMD);
			var jpg:JPGEncoder = new JPGEncoder(80);
			ServiceManager.ins().share(_currentPlatForm, text, jpg.encode(_shareBMD), _shareComplete, _shareError);
		}
		
		private function _shareComplete(result:String) : void
		{
			_native.toast(MyString.share_ok);
		}
		
		private function _shareError(result:String):void
		{
			_native.toast(MyString.share_failed);
		}
		
		
		private function _closeMe(data:*):void
		{
		}
		
		
		public function show(mode:IPlayMode) : void
		{
		}

		public function set clickAble(value:Boolean):void
		{
			_clickAble = value;
			this._snsSina.clickAble = this._snsTencent.clickAble = _clickAble;
		}

	}
}