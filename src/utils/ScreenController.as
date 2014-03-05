package utils
{
	import com.greensock.TweenLite;
	import com.pamakids.utils.Singleton;
	
	import flash.filesystem.File;
	
	import controllers.Assets;
	import controllers.MC;
	
	import models.code.ScreenCode;
	
	import starling.display.Image;
	import starling.utils.AssetManager;
	
	import views.components.MainLoading;
	import views.screens.BasicScreen;
	import views.screens.Games;
	import views.screens.Map;
	
	public class ScreenController extends Singleton
	{
		public static function instance():ScreenController
		{
			return Singleton.getInstance( ScreenController );
		}
		
		private var assets:AssetManager;
		private var mc:MC;
		private var bg:Image;
		private var crtScreen:BasicScreen;
		
		public function openScreen(ID:String, args:*=null):void
		{
			if(!assets)
			{
				loadAssets(ID, args);
				return;
			}
			delCrtScreen();
			switch(ID)
			{
				case ScreenCode.MAP:
					crtScreen = new Map();
					break;
				case ScreenCode.BOARD:
					break;
				case ScreenCode.GAME_LIST:
					crtScreen = new Games();
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
			addScreen( crtScreen );
		}
		
		private function addScreen(screen:BasicScreen):void
		{
			screen.alpha = 0;
			screen.touchable = false;
			mc.addToStage3D( screen );
			TweenLite.to( screen, 1, {alpha: 1, onComplete:function():void{
				screen.touchable = true;
			}});
		}
		
		private var mainLoading:MainLoading;
		private function loadAssets(ID:String, args:*=null):void
		{
			mc = MC.instance;
			mainLoading = new MainLoading();
			mc.addToStage2D( mainLoading, true );
			
			assets = Assets.instance.getAssetsManager( Assets.MAIN_UI );
			assets.enqueue(File.applicationDirectory.resolvePath("assets/mainUI"));
			assets.loadQueue( function(ratio:Number):void{
				if(ratio == 1)		//加载完成
				{
					bg = Assets.getImage( assets, "mainBG" );
					mc.addToStage3D( bg, true );
					openScreen( ID, args );
					TweenLite.to( mainLoading, 1.5, {alpha: 0, onComplete:function():void{
						mc.delChild( mainLoading );
					}});
				}
			});
		}
		
		/**
		 * 关闭当前显示页面
		 * @param clearBG 清除场景资源
		 */		
		private function delCrtScreen():void
		{
			var screen:BasicScreen = crtScreen;
			crtScreen = null;
			if(screen)
			{
				if(screen.parent)
					screen.parent.removeChild( screen );
				screen.dispose();
			}
		}
		private function delBG():void
		{
			if(!bg)
				return;
			mc.delChild( bg );
			bg.dispose();
			bg = null;
		}
		/**
		 * 清理方法
		 * @param disposeAssets	释放场景相关资源，释放后再次打开场景时需要重新加载资源，若值为false，则此方法只是清除当前显示场景，不会释放Assets.MainUI中的纹理资源
		 */		
		public function clean(disposeAssets:Boolean=false):void
		{
			delCrtScreen();
			if(disposeAssets)
			{
				delBG();
				this.mc = null;
				this.assets = null;
				Assets.instance.delAssetsManager( Assets.MAIN_UI );
			}
		}
	}
}