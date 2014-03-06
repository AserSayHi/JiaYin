package views.screens
{
	import controllers.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	/**
	 * 场景基类，拓展该类仅需重写 initScreenContent() 与 dispose方法
	 * @author kc2ong
	 */	
	public class BasicScreen extends Sprite
	{
		public static const INITIALIZED:String = "initialized";
		
		public function BasicScreen()
		{
		}
		
		protected var assets:AssetManager;
		
		final protected function getImage(name:String):Image
		{
			if(assets)
				return Assets.getImage( assets, name );
			else
				return null;
		}
		
		final public function initialize():void
		{
			assets = Assets.instance.getAssetsManager( Assets.MAIN_UI );
			initScreenContent();
			dispatchEvent( new Event( INITIALIZED ) );
		}
		
		protected function initScreenContent():void
		{
		}
		
		override public function dispose():void
		{
			assets = null;
			super.dispose();
		}
	}
}