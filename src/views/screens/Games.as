package views.screens
{
	import controllers.MC;
	
	import models.PosVO;
	import models.code.GameCode;
	
	import starling.display.Button;
	import starling.events.Event;
	/**
	 * 游戏列表
	 * @author Administrator
	 * 
	 */
	public class Games extends BasicScreen
	{
		public function Games()
		{
		}
		
		override protected function initScreenContent():void
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