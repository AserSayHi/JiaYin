package utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class StatusManager extends Sprite
	{
		private static var _instance:StatusManager;
		
		public static function getInstance():StatusManager
		{
			if (!_instance)
				_instance=new StatusManager();
			return _instance;
		}
		
		public function initialize():void
		{
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(e:Event):void
		{
			if(ifPause)
				return ;
			var obj:Object;
			var time:uint=getTimer();
			for (var func:Object in dicFunc)
			{
				obj=dicFunc[func];
				if (time - obj.last > obj.rate)
				{
					func();
					obj.last=time - (time - obj.last) % (obj.rate);
				}
			}
		}
		
		private var dicFunc:Dictionary = new Dictionary();;
		
		/**
		 * @param func	方法
		 * @param rate	调用频率，单位：毫秒
		 */
		public function addFunc(func:Function, rate:Number=1000):void
		{
			if (dicFunc.hasOwnProperty(func))
				return;
			dicFunc[func]={rate: rate, last: getTimer()};
		}
		
		public function delFunc(func:Function):void
		{
			if (dicFunc.hasOwnProperty(func))
				delete dicFunc[func];
		}
		
		public function clear():void
		{
			for (var obj:Object in dicFunc)
			{
				delete dicFunc[obj];
			}
		}
		
		private var ifPause:Boolean = false;
		public function pause():void
		{
			ifPause = true;
		}
		
		public function restart():void
		{
			ifPause = false;
		}
	}
}