package views.screens
{
	import controllers.Assets;
	
	import starling.display.Image;
	import starling.textures.Texture;
	

	public class Map extends BasicScreen
	{
		public function Map()
		{
			init();
		}
		
		private function init():void
		{
			assets = Assets.instance.getAssetsManager( Assets.MAIN_UI );
			
			initImage();
		}
		
		private function initImage():void
		{
			var t:Texture = assets.getTexture("1");
			var image:Image = new Image( t );
			image.scaleX = image.scaleY = .2;
			image.x = image.y = 0;
			this.addChild( image );
			trace(image.x, image.y, image.width, image.height);
			
			image = new Image( t );
			image.scaleX = image.scaleY = .2;
			image.x = WIDTH - image.width;
			image.y = 0;
			this.addChild( image );
			trace(image.x, image.y, image.width, image.height);
			
			image = new Image( t );
			image.scaleX = image.scaleY = .2;
			image.x = 0;
			image.y = HEIGHT - image.height;
			this.addChild( image );
			trace(image.x, image.y, image.width, image.height);
			
			image = new Image( t );
			image.scaleX = image.scaleY = .2;
			image.x = WIDTH - image.width;
			image.y = HEIGHT - image.height;
			this.addChild( image );
			trace(image.x, image.y, image.width, image.height);
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
	}
}