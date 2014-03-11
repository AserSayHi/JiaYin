package views.guides
{
	import controllers.Assets;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	import utils.StatusManager;

	/**
	 * 教学指引动画基类，拓展类仅需覆盖以下方法
	 */	
	public class BasicGuide extends Sprite
	{
		public static const INITIALIZED:String = "initialized";
		public static const ENDED:String = "ended";
		
		public function BasicGuide()
		{
			super();
		}
		
		protected var assets:AssetManager;
		protected var mStatus:StatusManager;
		final public function initialize():void
		{
			mStatus = StatusManager.getInstance();
			assets = Assets.instance.getAssetsManager( Assets.Games );
			initHandler();			//指引初始化
			dispatchEvent(new Event(INITIALIZED) );
		}
		/** 拓展类重写该方法 */
		protected function initHandler():void
		{
		}
		
		public function play():void
		{
		}
		
		public var state:int = -1;
	}
}