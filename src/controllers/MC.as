package controllers
{
	import com.pamakids.utils.Singleton;
	
	import starling.display.Sprite;
	
	import views.ScreenID;

	public class MC extends Singleton
	{
		private static function get instance():MC
		{
			return Singleton.getInstance(MC);
		}
		
		private var _main:Sprite;
		
		public function init(main:Sprite):void
		{
			this._main = main;
		}
		
		public function openScreen(ID:String):void
		{
			switch(ID)
			{
				case ScreenID.LOGIN:
					openLoginScreen();
					break;
			}
		}
		
		public function closeScreen(ID:String):void
		{
			switch(ID)
			{
				case ScreenID.LOGIN:
					closeLoginScreen();
					break;
			}
		}
		
		public function openGameScreen(ID:String):void
		{
		}
		
		public function closeGameScreen(ID:String):void
		{
		}
		
		private function openLoginScreen():void
		{
		}
		
		private function closeLoginScreen():void
		{
		}
		
	}
}