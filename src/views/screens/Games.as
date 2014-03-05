package views.screens
{
	import controllers.Assets;
	import controllers.MC;
	
	import models.PosVO;
	import models.code.GameCode;
	
	import starling.display.Button;
	import starling.events.Event;

	public class Games extends BasicScreen
	{
		public function Games()
		{
			super();
			
			initialize();
		}
		
		private function initialize():void
		{
			assets = Assets.instance.getAssetsManager( Assets.MAIN_UI );
			
			this.addEventListener( Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			var btn:Button = new Button(assets.getTexture("btn_startGame"));
			btn.x = PosVO.REAL_WIDTH - btn.width >> 1;
			btn.y = PosVO.REAL_HEIGHT - btn.height >> 1;
			this.addChild( btn );
			btn.addEventListener(Event.TRIGGERED, onTriggered);
		}
		
		private function onTriggered(e:Event):void
		{
			MC.instance.openGame( GameCode.TEMP, true );
		}		
		
	}
}