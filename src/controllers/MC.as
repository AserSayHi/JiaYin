package controllers
{
	import com.pamakids.utils.Singleton;
	
	import starling.display.Sprite;

	public class MC extends Singleton
	{
		private static var _instance:MC;
		private static function get instance():MC
		{
			return Singleton.getInstance(MC);
		}
		
		private var main:Sprite;
	}
}