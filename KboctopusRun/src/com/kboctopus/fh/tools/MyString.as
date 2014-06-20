package com.kboctopus.fh.tools
{
	import com.kboctopus.fh.consts.ConstGame;

	public class MyString
	{
		public static var share_ok:String;
		public static var share_failed:String;
		public static var share_text:String;
		public static var share_title:String;
		public static var btn_ok:String;
		public static var data_bad:String;
		
		public static function init():void
		{
			if(ConstGame.LANG == "zh")
			{
				share_ok = "恭喜你, 分享成功!";
				share_failed = "很抱歉, 分享失败";
				share_text = "";
				share_title = "分享";
				btn_ok = "确定";
				data_bad = "服务器连接不上";
			}
			else
			{
				share_ok = "Congratulations, share successed!";
				share_failed = "Sorry, failed to share";
				share_text = "";
				share_title = "Share";
				btn_ok = "OK";
				data_bad = "connect error!";
			}
		}
	}
}