package utils
{
	import com.greensock.TweenLite;
	import com.pamakids.utils.Singleton;
	
	import flash.filesystem.File;
	
	import controllers.Assets;
	import controllers.MC;
	
	import models.code.GameCode;
	
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	import views.components.MainLoading;
	import views.games.BasicGame;
	import views.games.Game1;
	import views.guides.BasicGuide;
	import views.guides.Guide1;
	

	public class GameController extends Singleton
	{
		public static function instance():GameController
		{
			return Singleton.getInstance( GameController );
		}
		
		/**
		 * 时间进度控制器
		 */		
		private var status:StatusManager = StatusManager.getInstance();
		private var assets:AssetManager;
		private var mc:MC;
		
		public function GameController()
		{
			super();
			initialize();
		}
		
		private function initialize():void
		{
			assets = Assets.instance.getAssetsManager( Assets.Games );
			mc = MC.instance;
		}
		
		private var crtID:String;
		private var crtGame:BasicGame;
		private var loading:MainLoading;
		private var crtGuide:BasicGuide;
		
		public function openGame(gameID:String, guide:Boolean=false):void
		{
			loading = new MainLoading();
			mc.addToStage2D( loading, true );
			//加载游戏资源
			crtID = gameID;
			assets.enqueue( File.applicationDirectory.resolvePath( "assets/games/"+crtID ) );
			assets.loadQueue( function(radio:Number):void{
				trace(radio);
				if(radio == 1)
				{
					if(guide)
					{
						
					}
					crtGame = gameFactory( gameID );
					crtGame.addEventListener( BasicGame.INITIALIZED, onGameState);
					crtGame.addEventListener( BasicGame.RESULT_SUCCESSED, onGameState);
					crtGame.addEventListener( BasicGame.RESULT_FAILED, onGameState);
					mc.addToStage3D( crtGame );
					crtGame.initialize();
				}
			});
		}
		
		public function pauseCrtGame():void
		{
		}
		public function continueCrtGame():void
		{
		}
		
		private function onGameState(e:Event):void
		{
			switch(e.type)
			{
				case BasicGame.INITIALIZED:
					TweenLite.to( loading, 1.5, {alpha: 0, onComplete:function():void{
						mc.delChild( loading );
						crtGame.start();
					}});
					break;
				case BasicGame.RESULT_SUCCESSED:
					break;
				case BasicGame.RESULT_FAILED:
					break;
			}
		}
		
		public function closeCrtGame():void
		{
		}
		
		private function gameFactory(id:String):BasicGame
		{
			var temp:BasicGame;
			switch(id)
			{
				case GameCode.TEMP:		//测试
					temp = new Game1();
					break;
			}
			return temp;
		}
		
		private function guideFactory(id:String):BasicGuide
		{
			var guide:BasicGuide;
			switch(id)
			{
				case GameCode.TEMP:
					guide = new Guide1();
					break;
			}
			return guide;
		}
	}
}