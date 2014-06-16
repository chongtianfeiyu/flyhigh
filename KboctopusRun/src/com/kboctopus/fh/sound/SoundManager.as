package com.kboctopus.fh.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class SoundManager
	{
		private static var _ins:SoundManager;
		
		private var _bgm:Sound;
		private var _bgmChannel:SoundChannel;
		private var _position:int;
		
		private var _sndDic:Dictionary = new Dictionary();
		
		public function SoundManager()
		{
		}
		
		
		public static function ins() : SoundManager
		{
			if (_ins==null)
			{
				_ins = new SoundManager();
			}
			return _ins;
		}
		
		
		public function init() : void
		{
			var snd:Sound = new Sound();
			snd.load(new URLRequest("assets/sound/good.mp3"));
			_sndDic["good"] = snd;
			
			snd = new Sound();
			snd.load(new URLRequest("assets/sound/over.mp3"));
			_sndDic["over"] = snd;
			
			_bgm = new Sound();
			_bgm.load(new URLRequest("assets/sound/bgm.mp3"));
			_bgmChannel = _bgm.play(0, 999999);
		}
		
		
		public function getSound(name:String) : Sound
		{
			return _sndDic[name];
		}
		
		
		public function pause():void
		{
			_position = _bgmChannel.position;
			_bgmChannel.stop();
		}
		
		public function resume():void
		{
			_bgmChannel = _bgm.play(_position, 999999);
		}
	}
}