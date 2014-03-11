package views.games
{
	import controllers.Assets;
	
	import models.PosVO;
	
	import starling.display.Image;

	public class Game_AppleBanana extends BasicGame
	{
		public function Game_AppleBanana()
		{
			super();
		}
		
		//override functions=============================================================
		override protected function initHandler():void
		{
			initBG();
		}
		
		private function initBG():void
		{
			setGameBG( assets.getTexture( "mainBG" ));
			var image:Image = Assets.getImage( assets, "image_other_0" );
			image.x = PosVO.REAL_WIDTH - image.width >> 1;
			image.y = 0;
			this.addChild( image );
			image.touchable = false;
		}
		
		override public function start():void
		{
		}
		
		override public function dispose():void
		{
		}
	}
}