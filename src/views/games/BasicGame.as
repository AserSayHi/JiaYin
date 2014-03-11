package views.games
{
	import controllers.Assets;
	import controllers.MC;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	/**
	 * 游戏基类
	 * @author kc2ong
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
		protected function getImage(name:String):Image
		{
			if(assets)
				return Assets.getImage( assets, name );
			else
				return null;
		}
		
		final public function initialize():void
		{
			assets = Assets.instance.getAssetsManager( Assets.Games );
			initHandler();
			dispatchEvent( new Event( INITIALIZED ));
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
			assets.dispose();
			assets = null;
			super.dispose();
		}
		//================================================================================
	}
}