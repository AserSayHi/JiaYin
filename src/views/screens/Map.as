package views.screens
{
	import flash.utils.Dictionary;
	
	import controllers.MC;
	
	import models.PosVO;
	import models.code.ScreenCode;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	

	public class Map extends BasicScreen
	{
		public function Map()
		{
		}
		
		override protected function initScreenContent():void
		{
			initMenu();
			initBtns();
		}
		
		private function initMenu():void
		{
			menu = [
				ScreenCode.MAIN, 			//主线内容
				ScreenCode.GAME_LIST,		//游戏列表
				ScreenCode.BOARD,			//your board
				ScreenCode.MORE,			//拓展页面
				ScreenCode.PARENTS			//父母登陆页面
			];
		}
		
		private var headIcon:Image;
		/**
		 * 菜单
		 */		
		private var menu:Array;
		private var btns:Dictionary;
		
		private function initBtns():void
		{
			btns = new Dictionary();
			
			var btn:Button;
			var name:String;
			const gap:uint = 15 * PosVO.scale;
			const paddingDown:uint = 50;
			const length:uint = menu.length;
			for(var i:int = length-1;i>=0;i--)
			{
				name = menu[i];
				btn = new Button( assets.getTexture("btn_" + name) );
				btn.name = name;
				btn.x = PosVO.REAL_WIDTH - btn.width >> 1;
				btn.y = PosVO.REAL_HEIGHT - paddingDown - (btn.height+gap)*(length-i);
				if(name == ScreenCode.MAIN)
					btn.y -= 30;
				this.addChild( btn );
				btn.addEventListener(Event.TRIGGERED, onTriggered);
				btns[name] = btn;
			}
		}
		
		private function onTriggered(e:Event):void
		{
			var name:String = (e.target as Object).name;
			trace(name);
			switch(name)
			{
				case ScreenCode.BOARD:
				case ScreenCode.MORE:
				case ScreenCode.PARENTS:
					return;
				case ScreenCode.MAIN:
				case ScreenCode.GAME_LIST:
					break;
			}
			MC.instance.openScreen( name );
		}
		
		override public function dispose():void
		{
			var btn:Button;
			for(var name:String in btns)
			{
				btn = btns[name];
				btn.removeEventListener(Event.TRIGGERED, onTriggered);
				btn.removeFromParent(true);
				delete btns[name];
				btn = null;
			}
			btns = null;
			super.dispose();
		}
	}
}