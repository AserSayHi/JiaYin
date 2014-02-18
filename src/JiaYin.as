package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	public class JiaYin extends Sprite
	{
		public function JiaYin()
		{
			super();
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private var star:Starling;
		protected function onStage(event:Event):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			star = new Starling(Main, stage);
			star.start();
		}
	}
}