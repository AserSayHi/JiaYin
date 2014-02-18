package
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onStage);
			trace(stage.stageWidth, stage.stageHeight);
		}
	}
}