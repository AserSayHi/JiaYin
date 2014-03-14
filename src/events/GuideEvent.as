package events
{
	import starling.events.Event;
	
	public class GuideEvent extends Event
	{
		public static const INITIALIZED:String = "guide_initialized";
		public static const CHANGED:String = "guide_step_changed";
		public static const ENDED:String = "guide_ended";
		
		public function GuideEvent(type:String, step:int=-1, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
			this._step = step;
		}
		
		private var _step:int;
		public function get crtStep():int
		{
			return _step;
		}
	}
}