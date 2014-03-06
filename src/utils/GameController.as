package utils
{
	import com.greensock.TweenLite;
	import com.pamakids.utils.Singleton;
	
	import flash.filesystem.File;
	
	import controllers.Assets;
	import controllers.MC;
	
	import models.code.GameCode;
	import models.code.ScreenCode;
	
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
		
		private var crtGameID:String;
		private var crtGame:BasicGame;
		private var loading:MainLoading;
		private var crtGuide:BasicGuide;
		private var ifGuide:Boolean;
		
		public function openGame(gameID:String, guide:Boolean=false):void
		{
			ifGuide = guide;
			trace("guide = " + ifGuide)
			loading = new MainLoading();
			mc.addToStage2D( loading, true );
			//加载游戏资源
			crtGameID = gameID;
			assets.enqueue( File.applicationDirectory.resolvePath( "assets/games/"+crtGameID ) );
			assets.loadQueue( function(radio:Number):void{
				if(radio == 1)
				{
					if(ifGuide)
					{
						//初始化指引，并侦听BasicGuide.INITIALIZED与BasicGuide.ENDED事件：
						//当侦听到 BasicGuide.INITIALIZED 事件时清除 loading组件，同时调用guide.start()方法开始指引动画
						//当侦听到BasicGuide.ENDED事件时，表示guide动画已播放完成，清除 guide，初始化 crtGame
						//当侦听到 crtGame 派发的 INITIALIZED 方法时清除 guide，同时调用crtGame。start()方法开始游戏
						crtGuide = guideFactory( crtGameID );
						crtGuide.addEventListener(BasicGuide.INITIALIZED, guideStateHandler);
						crtGuide.addEventListener(BasicGuide.ENDED, guideStateHandler);
						mc.addToStage3D( crtGuide );
						crtGuide.initialize();
						return;
					}
					else
					{
						//初始化crtGame，并侦听相关游戏事件
						//当侦听到crtGame派发的INITIALIZED事件时清除loading，并调用crtGame。start()方法开始游戏
						initGame();
					}
				}
			});
		}
		
		private function guideStateHandler(e:Event):void
		{
			switch(e.type)
			{
				case BasicGuide.INITIALIZED:	//清除loading
					TweenLite.to( loading, 0.5, {alpha: 0, onComplete:function():void{
						mc.delChild( loading );
						loading = null;
					}});
					break;
				case BasicGuide.ENDED:
					initGame();
					break;
			}
		}
		
		private function initGame():void
		{
			crtGame = gameFactory( crtGameID );
			crtGame.addEventListener( BasicGame.INITIALIZED, onGameState);
			crtGame.addEventListener( BasicGame.RESULT_SUCCESSED, onGameState);
			crtGame.addEventListener( BasicGame.RESULT_FAILED, onGameState);
			mc.addToStage3D( crtGame );
			if(crtGuide)
				crtGame.parent.swapChildren( crtGame, crtGuide );
			crtGame.visible = false;
			crtGame.initialize();
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
					crtGame.visible = true;
					if( crtGuide )
					{
						TweenLite.to( crtGuide, 1.5, {alpha: 0, onComplete:function():void{
							mc.delChild( crtGuide );
							crtGuide.dispose();
							crtGuide = null;
							crtGame.start();
						}});
					}
					else
					{
						TweenLite.to( loading, 1.5, {alpha: 0, onComplete:function():void{
							mc.delChild( loading );
							loading = null;
							crtGame.start();
						}});
					}
					break;
				case BasicGame.RESULT_SUCCESSED:
					break;
				case BasicGame.RESULT_FAILED:
					break;
				case BasicGame.ENDED:
					MC.instance.openScreen( ScreenCode.MAP );
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