package views.screens
{
	import controllers.MC;
	
	import models.PosVO;
	import models.code.GameCode;
	import models.code.ScreenCode;
	
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
			test();
			getGameVO();
		}
		
		private function getGameVO():void
		{
		}
		
		private function initList():void
		{
		}
		
		private function test():void
		{
			btn_start = new Button(assets.getTexture("btn_startGame"));
			btn_start.x = PosVO.REAL_WIDTH - btn_start.width >> 1;
			btn_start.y = PosVO.REAL_HEIGHT - btn_start.height >> 1;
			this.addChild( btn_start );
			btn_start.addEventListener(Event.TRIGGERED, onTriggered);
			
			btn_map = new Button(assets.getTexture("btn_map"));
			btn_map.x = btn_start.x;
			btn_map.y = btn_start.y + 60;
			this.addChild( btn_map );
			btn_map.addEventListener(Event.TRIGGERED, onTriggered);
		}
		private var btn_start:Button;
		private var btn_map:Button;
		private function onTriggered(e:Event):void
		{
			switch(e.target)
			{
				case btn_start:
//					MC.instance.openGame( GameCode.RunStop, false );
					MC.instance.openGame( GameCode.AppleBanana, false );
					break;
				case btn_map:
					MC.instance.openScreen( ScreenCode.MAP );
					break;
			}
		}
		
		
		override public function dispose():void
		{
			if(btn_start)
			{
				btn_start.removeEventListener(Event.TRIGGERED, onTriggered);
				btn_start.removeFromParent( true );
				btn_start = null;
			}
			if(btn_map)
			{
				btn_map.removeEventListener(Event.TRIGGERED, onTriggered);
				btn_map.removeFromParent( true );
				btn_map = null;
			}
			super.dispose();
		}
		
	}
}