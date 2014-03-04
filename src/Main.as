package
{
	import controllers.DC;
	import controllers.MC;
	
	import starling.display.Sprite;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			super();
			
			initialize();
		}
		
		private function initialize():void
		{
			DC.instance.initialize();
			MC.instance.initialize(this);
		}
	}
}