package utils
{
	import com.pamakids.utils.Singleton;
	
	import flash.filesystem.File;
	
	import controllers.MC;
	
	import models.code.ScreenCode;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.utils.AssetManager;
	
	import views.screens.BasicScreen;
	import views.screens.Content;
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
		private var mainBG:Image;
		private var prevScreen:BasicScreen = null;
		private var crtScreen:BasicScreen = null;
		
		/**
		 * 根据场景ID打开指定场景，内部封装了资源的加载逻辑
		 * @param screenID	由ScreenCode类静态常量定义
		 */	
		public function openScreen(ID:String, args:*=null):void
		{
			if(!assets)
			{
				loadAssets(ID, args);
				return;
			}
			prevScreen = crtScreen;
			if(prevScreen)
				prevScreen.touchable = false;
			crtScreen = screenFactory( ID, args );
			crtScreen.addEventListener( BasicScreen.INITIALIZED, onInitialized);
			crtScreen.initialize();
		}
		
		private function onInitialized():void
		{
			showCrtScreen();
		}
		private function showCrtScreen():void
		{
			crtScreen.touchable = false;
			mc.addToStage3D( crtScreen );
			crtScreen.alpha = 0;
			if(prevScreen)
				prevScreen.parent.swapChildren( prevScreen, crtScreen );
			StatusManager.getInstance().addFunc( 
				function():void{
					crtScreen.alpha += 0.1;
					if(prevScreen)
						prevScreen.alpha = 1 - crtScreen.alpha;
				}, 50, 10, 
				function():void{
					crtScreen.alpha = 1;
					crtScreen.touchable = true;
					delDisplayObject(prevScreen);
				});
			mc.hideLoading();
		}
		
		private function loadAssets(ID:String, args:*=null):void
		{
			mc = MC.instance;
			mc.showLoading();
			
			if(!FlashAssets.checkInitialized( FlashAssets.GLOBAL ))
			{
				//初次运行，加载全局动画资源
				FlashAssets.getInstance( FlashAssets.GLOBAL ).loadSWF( "assets/swfs/mainUI.swf",function():void{
					loadAssets(ID, args);
				});
				return;
			}
			
			assets = StarlingAssets.instance.getAssetsManager( StarlingAssets.SCREEN );
			assets.enqueue(File.applicationDirectory.resolvePath("assets/mainUI"));
			assets.loadQueue( function(ratio:Number):void{
				if(ratio == 1)		//加载完成
				{
					mainBG = new Image( assets.getTexture( "mainBG" ));
					mc.addToStage3D( mainBG, true );
					openScreen( ID, args );
				}
			});
		}
		
		private function screenFactory(id:String, args:*=null):BasicScreen
		{
			var screen:BasicScreen;
			switch(id)
			{
				case ScreenCode.MAP:
					screen = new Map();
					break;
				case ScreenCode.BOARD:
					break;
				case ScreenCode.GAME_LIST:
					screen = new Games();
					break;
				case ScreenCode.LOGIN:
					break;
				case ScreenCode.MORE:
					break;
				case ScreenCode.PARENTS:
					break;
				case ScreenCode.REGISTER:
					break;
				case ScreenCode.MAIN:
					screen = new Content();
					break;
			}
			return screen;
		}
		
		/**
		 * 清理方法
		 * @param disposeAssets	释放场景相关资源，释放后再次打开场景时需要重新加载资源，若值为false，则此方法只是清除当前显示场景，不会释放Assets.MainUI中的纹理资源
		 */		
		public function clean(disposeAssets:Boolean=false):void
		{
			delDisplayObject( crtScreen );
			crtScreen = null;
			delDisplayObject( prevScreen );
			prevScreen = null;
			if(disposeAssets)
			{
				delBG();
				this.mc = null;
				this.assets = null;
				StarlingAssets.instance.delAssetsManager( StarlingAssets.SCREEN );
			}
		}
		
		private function delBG():void
		{
			if(!mainBG)
				return;
			mc.delChild( mainBG );
			mainBG.dispose();
			mainBG = null;
		}
		
		private function delDisplayObject(obj:DisplayObject):void
		{
			if(!obj)
				return;
			obj.removeEventListeners( BasicScreen.INITIALIZED );
			obj.removeFromParent( true );
		}
	}
}