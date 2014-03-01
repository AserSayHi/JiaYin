package views.components
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import controllers.MC;
	
	import utils.StatusManager;
	
	public class MainLoading extends Sprite
	{
//		[Embed(source="/assets/embed/login.jpg")]
		[Embed(source="/assets/embed/1.png")]
		private static const BG:Class;
		[Embed(source="/assets/embed/loading.png")]
		private static const LoadingPNG:Class;
		
		public function MainLoading()
		{
			initialize();
			this.addEventListener(Event.ADDED_TO_STAGE, eventHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, eventHandler);
		}
		
		protected function eventHandler(e:Event):void
		{
			switch(e.type)
			{
				case Event.ADDED_TO_STAGE:
					StatusManager.getInstance().addFunc( onTimer, 50 );
					break;
				case Event.REMOVED_FROM_STAGE:
					dispose();
					break;
			}
		}
		
		private var bg:Bitmap;
		private var loading:Bitmap;
		private var sprite:Sprite;
		
		private function initialize():void
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			bg = new BG();
			this.addChild( bg );
			
			sprite = new Sprite();
			loading = new LoadingPNG();
			sprite.addChild( loading );
			loading.x = - loading.width >> 1;
			loading.y = - loading.height >> 1;
			this.addChild( sprite );
			sprite.x = MC.CENTER.x;
			sprite.y = MC.CENTER.y;
		}
		
		private function onTimer():void
		{
			sprite.rotation += 30;
		}
		
		private function dispose():void
		{
			StatusManager.getInstance().delFunc( onTimer );
			this.removeChildren();
			this.bg = null;
			this.loading = null;
		}
		
	}
}