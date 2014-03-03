package
{
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
			MC.instance.initialize(this);
		}
	}
}