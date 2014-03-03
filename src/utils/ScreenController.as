package utils
{
	import com.pamakids.utils.Singleton;
	
	import controllers.Assets;
	import controllers.MC;
	
	import models.code.ScreenCode;
	
	import starling.utils.AssetManager;
	
	import views.screens.BasicScreen;
	import views.screens.Map;
	
	public class ScreenController extends Singleton
	{
		public static function instance():ScreenController
		{
			return Singleton.getInstance( ScreenController );
		}
		
		public function ScreenController()
		{
			super();
			
			initialize();
		}
		
		private var assets:AssetManager;
		private var mc:MC;
		private function initialize():void
		{
			assets = Assets.instance.getAssetsManager( Assets.MAIN_UI );
			mc = MC.instance;
		}
		
		private var screen:BasicScreen;
		public function openScreen(ID:String, args:*=null):void
		{
			delCrtScreen();
			switch(ID)
			{
				case ScreenCode.MAP:
					screen = new Map();
					break;
				case ScreenCode.BOARD:
					break;
				case ScreenCode.GAME_LIST:
					break;
				case ScreenCode.LOGIN:
					break;
				case ScreenCode.MORE:
					break;
				case ScreenCode.PARENTS:
					break;
				case ScreenCode.REGISTER:
					break;
			}
			mc.addToStage3D( screen );
		}
		
		/**
		 * 关闭当前显示页面
		 */		
		public function delCrtScreen():void
		{
			if(screen)
			{
				if(screen.parent)
					screen.parent.removeChild( screen );
				screen.dispose();
			}
			screen = null;	
		}
	}
}