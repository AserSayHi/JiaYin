package views.games
{
	import controllers.Assets;
	import controllers.MC;
	
	import starling.display.Image;
	import starling.display.Sprite;
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
		
		public function BasicGame()
		{
			super();
			
			assets = Assets.instance.getAssetsManager( Assets.Games );
		}
		
		protected var assets:AssetManager;
		
		protected function getImage(name:String):Image
		{
			if(assets)
				return Assets.getImage( assets, name );
			else
				return null;
		}
		
		private var BG:Image;
		/** 初始化游戏背景 */
		protected function initBG(texture:Texture):void
		{
			BG = new Image(texture);
			MC.instance.addToStage3D( BG, true );
		}
		/** 清除游戏背景 */
		protected function delBG():void
		{
			MC.instance.delChild( BG );
			BG.dispose();
			BG = null;
		}
		
		//override functions=============================================================
		/**
		 * @param teach	是否需要打开指引
		 */		
		public function initialize(teach:Boolean=false):void
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
		//================================================================================
	}
}