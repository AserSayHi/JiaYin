package views.games
{
	import controllers.Assets;
	import controllers.MC;
	
	import models.code.ScreenCode;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	import utils.GameController;
	import utils.StatusManager;

	/**
	 * 拓展类需重写 initHandler()方法来完成初始化，初始化完成时调用initCompleted()派发完成事件
	 */	
	public class BasicGame extends Sprite
	{
		public static const INITIALIZED:String = "initialized";
		public static const RESULT_SUCCESSED:String = "successed";
		public static const RESULT_FAILED:String = "failed";
		public static const ENDED:String = "ended";
		
		public function BasicGame()
		{
			super();
		}
		
		protected var assets:AssetManager;
		protected var statusM:StatusManager;
		protected var controller:GameController;
		
		protected function getImage(name:String):Image
		{
			if(assets)
				return new Image( assets.getTexture( name ));
			else
				return null;
		}
		
		final public function initialize():void
		{
			assets = Assets.instance.getAssetsManager( Assets.Games );
			statusM = StatusManager.getInstance();
			controller = MC.instance.getGameController();
			initHandler();
			initHomeBtn();
		}
		
		private var btn_home:Button;
		private function initHomeBtn():void
		{
			btn_home = new Button( assets.getTexture( "btn_home_up" ) );
			btn_home.downState = assets.getTexture( "btn_home_down" );
			btn_home.x = btn_home.y = 10;
			this.addChild( btn_home );
			btn_home.addEventListener( Event.TRIGGERED, onTriggered );
		}
		
		/**
		 * 终止游戏，并退出
		 * @param e
		 */		
		private function onTriggered(e:Event):void
		{
			//关闭游戏，并离开游戏场景
			controller.closeGame();
			MC.instance.getScreenController().openScreen( ScreenCode.MAP );
		}
		
		private var BG:Image;
		/** 初始化游戏背景 */
		final protected function setGameBG(texture:Texture):void
		{
			if(BG && BG.texture == texture)
				return;
			if(!BG)
			{
				BG = new Image( texture );
				MC.instance.addToStage3D( BG, true );
			}else
				BG.texture = texture;
		}
		/** 清除游戏背景 */
		protected function delGameBG():void
		{
			if(!BG)
				return;
			MC.instance.delChild( BG );
			BG.dispose();
			BG = null;
		}
		
		/**
		 * 初始化完成后调用该方法
		 */		
		final protected function initCompleted():void
		{
			dispatchEvent( new Event( INITIALIZED ));
		}
		
		//override functions=============================================================
		protected function initHandler():void
		{
		}
		public function start():void
		{
		}
		public function restart():void
		{
		}
		public function end():void
		{
		}
		public function pauseGame():void
		{
		}
		public function continueGame():void
		{
		}
		override public function dispose():void
		{
			delGameBG();
			if( btn_home )
			{
				btn_home.removeEventListener(Event.TRIGGERED, onTriggered );
				btn_home.removeFromParent( true );
				btn_home = null;
			}
			assets = null;
			controller = null;
			statusM = null;
			super.dispose();
		}
		//================================================================================
	}
}