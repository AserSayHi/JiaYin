package utils
{
	import com.greensock.TweenLite;
	import com.pamakids.utils.Singleton;
	
	import flash.filesystem.File;
	
	import controllers.MC;
	
	import events.GuideEvent;
	
	import models.PosVO;
	import models.code.GameCode;
	import models.code.ScreenCode;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	import views.components.ResultBoard;
	import views.games.BasicGame;
	import views.games.Game_AppleBanana;
	import views.games.Game_RunStop;
	import views.guides.BasicGuide;
	import views.guides.Guide_AppleBanana;
	import views.guides.Guide_RunStop;
	

	public class GameController extends Singleton
	{
		public static function instance():GameController
		{
			return Singleton.getInstance( GameController );
		}
		
		/**
		 * 时间进度控制器
		 */		
		private var status:StatusManager;
		private var assets:AssetManager;
		private var mc:MC;
		
		private var crtGameID:String;
		private var crtGame:BasicGame;
		private var crtGuide:BasicGuide;
		private var ifGuide:Boolean;
		
		public function checkIfGuide():Boolean
		{
			return ifGuide;
		}
		
		/**
		 * 打开游戏模块
		 * @param gameID		游戏id
		 * @param needVoice		是否需要语音识别模块
		 * @param guide			是否需要游戏指引
		 * 
		 */		
		public function openGame(gameID:String, needVoice:Boolean=false, guide:Boolean=false):void
		{
				
			assets = StarlingAssets.instance.getAssetsManager( StarlingAssets.Games );
			status = StatusManager.getInstance();
			mc = MC.instance;

			//初始化语音识别控件
			if(needVoice)
				Voice.instance.initRecognizer();
			
			ifGuide = guide;
			
			mc.showLoading();
			//加载游戏资源
			crtGameID = gameID;
			assets.enqueue( File.applicationDirectory.resolvePath( "assets/games/global" ) );
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
						crtGuide.addEventListener(GuideEvent.INITIALIZED, guideStateHandler);
						crtGuide.addEventListener(GuideEvent.ENDED, guideStateHandler);
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
				case GuideEvent.INITIALIZED:	//清除loading，之后开始播放指引
					mc.hideLoading( crtGuide.play );
					break;
				case GuideEvent.ENDED:
					initGame();
					break;
			}
		}
		
		private function initGame():void
		{
			crtGame = gameFactory( crtGameID );
			crtGame.addEventListener( BasicGame.INITIALIZED, onGameState);
			crtGame.addEventListener( BasicGame.ENDED, onGameState);
			crtGame.touchable = false;
			mc.addToStage3D( crtGame );
			if(crtGuide)
				crtGame.parent.swapChildren( crtGame, crtGuide );
			crtGame.visible = false;
			crtGame.initialize();
		}
		
		public function pauseCrtGame():void
		{
			crtGame.pauseGame();
		}
		
		public function continueCrtGame():void
		{
			crtGame.continueGame();
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
							crtGame.touchable = true;
							crtGame.start();
						}});
					}
					else
					{
						mc.hideLoading( function():void{
							crtGame.touchable = true;
							crtGame.start();
						});
					}
					break;
				case BasicGame.ENDED:
					closeGame();
					MC.instance.getScreenController().openScreen( ScreenCode.MAP );
					break;
			}
		}
		
		public function closeGame():void
		{
			if(result)
			{
				result.removeFromParent( true );
				result = null;
			}
			if(crtGuide)
			{
				crtGuide.removeEventListener(GuideEvent.INITIALIZED, guideStateHandler);
				crtGuide.removeEventListener(GuideEvent.ENDED, guideStateHandler);
				crtGuide.removeFromParent( true );
				crtGuide = null;
			}
			if(crtGame)
			{
				crtGame.removeEventListener( BasicGame.INITIALIZED, onGameState);
				crtGame.removeFromParent(true);
				crtGame = null;
			}
			assets = null;
			status = null;
			mc = null;
			StarlingAssets.instance.delAssetsManager( StarlingAssets.Games );	//清理资源
			FlashAssets.delInstance( FlashAssets.GAMES );		//清理游戏中的原生动画资源
		}
		
		private function gameFactory(id:String):BasicGame
		{
			var temp:BasicGame;
			switch(id)
			{
				case GameCode.RunStop:		//测试
					temp = new Game_RunStop();
					break;
				case GameCode.AppleBanana:		//测试
					temp = new Game_AppleBanana();
					break;
			}
			return temp;
		}
		
		private function guideFactory(id:String):BasicGuide
		{
			var guide:BasicGuide;
			switch(id)
			{
				case GameCode.RunStop:
					guide = new Guide_RunStop();
					break;
				case GameCode.AppleBanana:
					guide = new Guide_AppleBanana();
					break;
			}
			return guide;
		}
		
		/**
		 * 显示成绩面板
		 * @param stars	所获得星星数量
		 */		
		public function showResultBoard(stars:int):void
		{
			if(!mask)
			{
				mask = new Image(assets.getTexture("image_mask"));
				mask.alpha = .5;
				mask.width = PosVO.LOGIC_WIDTH;
				mask.height = PosVO.LOGIC_HEIGHT;
			}
			crtGame.addChild( mask );
			
			if(!result)
			{
				result = new ResultBoard();
				result.pivotX = result.width >> 1;
				result.pivotY = result.height >> 1;
				result.x = PosVO.REAL_WIDTH >> 1;
				result.y = PosVO.REAL_HEIGHT >> 1;
			}
			crtGame.addChild( result );
			result.showStars( stars );
		}
		private var result:ResultBoard;
		private var mask:Image;
		public function hideResultBoard():void
		{
			mask.removeFromParent();
			result.removeFromParent();
		}
		
		public function getCrtGame():BasicGame
		{
			return crtGame;
		}
	}
}