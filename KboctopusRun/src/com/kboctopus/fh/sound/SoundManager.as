package com.kboctopus.fh.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class SoundManager
	{
		private static var _ins:SoundManager;
		
		private var _sndDic:Dictionary = new Dictionary();
		private var _bgmDic:Dictionary = new Dictionary();
		private var _currentChannel:SoundChannel;
		private var _currentBGM:Sound;
		
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
			snd.load(new URLRequest("assets/sound/bad.mp3"));
			_sndDic["bad"] = snd;
			
			snd = new Sound();
			snd.load(new URLRequest("assets/sound/bg.mp3"));
			_bgmDic["bg"] = snd;
			
			snd = new Sound();
			snd.load(new URLRequest("assets/sound/go.mp3"));
			_bgmDic["go"] = snd;
			
			snd = new Sound();
			snd.load(new URLRequest("assets/sound/classic.mp3"));
			_bgmDic["classic"] = snd;
		}
		
		
		public function getSound(name:String) : Sound
		{
			return _sndDic[name];
		}
		
		
		public function playBGM(name:String) : void
		{
			if (_currentChannel != null)
			{
				stop();
			}
			_currentBGM = _bgmDic[name];
			_currentChannel = _currentBGM.play(0, 999999);
		}
		
		public function stop() : void
		{
			_currentChannel.stop();
			_currentChannel = null;
		}
		
		public function pause():void
		{
			_currentChannel.stop();
		}
		
		public function resume():void
		{
			_currentChannel = _currentBGM.play(0, 999999);
		}
	}
}