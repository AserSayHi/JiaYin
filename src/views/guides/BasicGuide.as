package views.guides
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	import utils.StatusManager;
	/**
	 * 教学指引动画基类，拓展类仅需覆盖以下方法：<p>
	 * 拓展类需覆盖方法：
	 * initGuideContent();	
	 * onTimerHandler();
	 */	
	public class BasicGuide extends Sprite
	{
		public static const INITIALIZED:String = "initialized";
		public static const ENDED:String = "ended";
		
		public function BasicGuide()
		{
			super();
		}
		final public function initialize():void
		{
			mStatus = StatusManager.getInstance();
			initGuideContent();
			dispatchEvent(new Event(INITIALIZED) );
		}
		
		protected function initGuideContent():void
		{
		}
		
		final public function play():void
		{
			mStatus.addFunc( onTimer );
		}
		
		private function onTimer():void
		{
			if(isPaused)
				return;
			timerHandler();
			checkEnded();
		}
		
		//检测结束
		private function checkEnded():void
		{
			if(true)
				dispatchEvent( new Event( ENDED ));
		}
		
		/**
		 * 动画进程控制
		 */		
		protected function timerHandler():void
		{
		}
		
		protected var isPaused:Boolean = false;
		public function pause():void
		{
			isPaused = true;
		}
		
		public function rePlay():void
		{
		}
		
		public var state:int = -1;
		public var mStatus:StatusManager;
	}
}