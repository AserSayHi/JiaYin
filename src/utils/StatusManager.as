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
		
		private var initialized:Boolean = false;
		public function initialize():void
		{
			if(initialized)
				return;
			initialized = true;
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
					if(obj.times == obj.maxTimes)
					{
						if(obj.complete)
							obj.complete();
						delFunc( func as Function );
						return;
					}
					func();
					obj.last=time - (time - obj.last) % (obj.rate);
					obj.times += 1;
				}
			}
		}
		
		private var dicFunc:Dictionary = new Dictionary();;
		
		/**
		 * @param func	被调用的方法
		 * @param rate	调用频率，单位：毫秒
		 * @param times	调用次数，默认为-1，即无次数上限
		 * @param onComplete 调用完成
		 */		
		public function addFunc(func:Function, rate:Number=1000, times:int=-1, onComplete:Function=null):void
		{
			if (dicFunc.hasOwnProperty(func))
				return;
			dicFunc[func]={rate: rate, last: getTimer(), times: 0, maxTimes: times, complete: onComplete};
		}
		
		public function delFunc(func:Function):void
		{
			for(var obj:Object in dicFunc)
			{
				if(obj == func)
				{
					delete dicFunc[func];
					return;
				}
			}
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