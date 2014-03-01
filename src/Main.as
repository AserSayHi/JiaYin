package
{
	import controllers.MC;
	
	import starling.display.Sprite;
	
	import utils.StatusManager;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			super();
			
			initialize();
		}
		
		private function initialize():void
		{
			StatusManager.getInstance().initialize();
			MC.instance.initialize(this);
		}
	}
}