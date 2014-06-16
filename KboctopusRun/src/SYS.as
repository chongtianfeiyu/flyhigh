package 
{
    import flash.system.Capabilities;

    public class SYS
    {
		public static function get admobBannerID():String{
			return isIOS?"ca-app-pub-1069429310304368/4278640937":"ca-app-pub-1069429310304368/4278640937";
		}
		public static function get baiduID():String{
			return isIOS?"debug":"debug";
		}
		public static function get isIOS():Boolean
		{
			return Capabilities.manufacturer.indexOf("iOS") != -1;
		}
		
    }
}