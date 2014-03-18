package views.screens
{
	import controllers.Assets;
	import controllers.MC;
	import utils.ScreenController;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	/**
	 * 场景基类，拓展该类须重写 initHandler()方法来完成初始化，初始化完成时调用initCompleted()派发完成事件
	 * @author kc2ong
	 */	
	public class BasicScreen extends Sprite
	{
		public static const INITIALIZED:String = "initialized";
		
		public function BasicScreen()
		{
		}
		
		protected var assets:AssetManager = Assets.instance.getAssetsManager( Assets.MAIN_UI );
		protected var controller:ScreenController = MC.instance.getScreenController();
		
		final protected function getImage(name:String):Image
		{
			if(assets)
				return new Image( assets.getTexture( name ));
			else
				return null;
		}
		
		final public function initialize():void
		{
			initHandler();
		}
		
		protected function initHandler():void
		{
		}
		
		/**初始化完成时调用*/
		final protected function initCompleted():void
		{
			dispatchEvent( new Event( INITIALIZED ) );
		}
		
		override public function dispose():void
		{
			assets = null;
			controller = null;
			super.dispose();
		}
	}
}