package views.games
{
	import models.PosVO;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class Game_RunStop extends BasicGame
	{
		public function Game_RunStop()
		{
			super();
		}
		
		//override functions=============================================================
		override protected function initHandler():void
		{
			setGameBG( assets.getTexture( "mainBG" ));
			initImage();
			initKid();
		}
		
		private function initKid():void
		{
		}
		
		private var image_run:Image;
		private var image_run_light:Texture;
		private var image_run_black:Texture;
		private var image_stop:Image;
		private var image_stop_light:Texture;
		private var image_stop_black:Texture;
		private function initImage():void
		{
			var image:Image = getImage( "image_other_0" );
			this.addChild( image );
			image.x = PosVO.REAL_WIDTH - image.width;
			image.y = 50;
			
			image_run_light = assets.getTexture( "btn_run_down" );
			image_run_black = assets.getTexture( "btn_run_up" );
			image_stop_light = assets.getTexture( "btn_stop_down" );
			image_stop_black = assets.getTexture( "btn_stop_up" );
			
			image_stop = new Image( image_stop_black );
			image_stop.x = PosVO.REAL_WIDTH - 372;
			image_stop.y = 15;
			this.addChild( image_stop );
			
			image_run = new Image( image_run_black );
			image_run.x = PosVO.REAL_WIDTH - 180;
			image_run.y = 36;
			this.addChild( image_run );
			
			image.touchable = image_run.touchable = image_stop.touchable = false;
		}
		
		override public function start():void
		{
		}
		
		override public function dispose():void
		{
		}
	}
}