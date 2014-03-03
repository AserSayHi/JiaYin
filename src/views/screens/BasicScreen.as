package views.screens
{
	import controllers.Assets;
	
	import models.PosVO;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	public class BasicScreen extends Sprite
	{
		public function BasicScreen()
		{
		}
		
		protected const WIDTH:uint = PosVO.REAL_WIDTH;
		protected const HEIGHT:uint = PosVO.REAL_HEIGHT;
		
		protected var assets:AssetManager;
		
		protected function getImage(name:String):Image
		{
			if(assets)
				return Assets.getImage( assets, name );
			else
				return null;
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
	}
}