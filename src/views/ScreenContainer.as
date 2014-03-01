package views
{
	import controllers.Assets;
	import controllers.MC;
	
	import models.code.ScreenCode;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class ScreenContainer extends Sprite
	{
		public function ScreenContainer()
		{
			super();
			
			initialize();
		}
		
		private var assets:AssetManager;
		private function initialize():void
		{
			assets = Assets.instance.getAssetsManager( Assets.MAIN_UI );
			
			bg_1 = Assets.getImage( assets, "1" );
			this.addChild( bg_1 );
			bg_2 = Assets.getImage( assets, "2" );
			this.addChild( bg_2 );
			
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			if(touch&&touch.phase == TouchPhase.ENDED)
				swapChildren(bg_1, bg_2);
		}
		
		private var bg_1:Image;
		private var bg_2:Image;
		
		public function openScreen(ID:String):void
		{
			switch(ID)
			{
				case ScreenCode.MAP:
					break;
			}
		}
		
		public function closeScreen(ID:String, params:*=null):void
		{
			switch(ID)
			{
			}
		}
		
		public function openGameScreen(ID:String):void
		{
		}
		
		public function closeGameScreen(ID:String):void
		{
		}
	}
}