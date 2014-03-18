package views.screens
{
	import utils.GameController;
	import controllers.MC;
	
	import models.PosVO;
	import models.code.GameCode;
	import models.code.ScreenCode;
	
	import starling.display.Button;
	import starling.events.Event;

	/**
	 * 游戏列表
	 * @author Administrator
	 */
	public class Games extends BasicScreen
	{
		public function Games()
		{
		}
		
		private var gameController:GameController;
		
		override protected function initHandler():void
		{
			gameController = MC.instance.getGameController();
			getGameVO();
			test();
			initCompleted();
		}
		
		private function getGameVO():void
		{
		}
		
		private function initList():void
		{
		}
		
		private function test():void
		{
			btn_runstop = new Button(assets.getTexture("btn_startGame"));
			btn_runstop.x = PosVO.REAL_WIDTH - btn_runstop.width >> 1;
			btn_runstop.y = ( PosVO.REAL_HEIGHT - btn_runstop.height >> 1 ) + 60;
			this.addChild( btn_runstop );
			btn_runstop.addEventListener(Event.TRIGGERED, onTriggered);
			
			btn_applebanana = new Button(assets.getTexture("btn_startGame"));
			btn_applebanana.x = btn_runstop.x;
			btn_applebanana.y = btn_runstop.y + 60
			this.addChild( btn_applebanana );
			btn_applebanana.addEventListener(Event.TRIGGERED, onTriggered);
			
			btn_map = new Button(assets.getTexture("btn_map"));
			btn_map.x = btn_runstop.x;
			btn_map.y = btn_applebanana.y + 60;
			this.addChild( btn_map );
			btn_map.addEventListener(Event.TRIGGERED, onTriggered);
		}
		
		private var btn_runstop:Button;
		private var btn_applebanana:Button;
		private var btn_map:Button;
		
		private function onTriggered(e:Event):void
		{
			switch(e.target)
			{
				case btn_runstop:
					controller.clean(true);
					gameController.openGame( GameCode.RunStop, false );
					break;
				case btn_applebanana:
					controller.clean(true);
					gameController.openGame( GameCode.AppleBanana, false );
					break;
				case btn_map:
					controller.openScreen( ScreenCode.MAP );
					break;
			}
		}
		
		
		override public function dispose():void
		{
			if(btn_runstop)
			{
				btn_runstop.removeEventListener(Event.TRIGGERED, onTriggered);
				btn_runstop.removeFromParent( true );
				btn_runstop = null;
			}
			if(btn_applebanana)
			{
				btn_applebanana.removeEventListener(Event.TRIGGERED, onTriggered);
				btn_applebanana.removeFromParent( true );
				btn_applebanana = null;
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