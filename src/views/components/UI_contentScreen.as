package views.components
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Cubic;
	
	import flash.utils.Dictionary;
	
	import controllers.Assets;
	import controllers.MC;
	
	import models.code.ScreenCode;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class UI_contentScreen extends Sprite
	{
		public function UI_contentScreen()
		{
			init();
		}
		
		private var assets:AssetManager;
		private var bg:Image;
		private var head:Image;
		private var btn_games:Button;
		private var btn_board:Button;
		private var btn_parents:Button;
		private var btn_sound:Button;
		private var btn_map:Button;
		private var menu:Dictionary;
		private function init():void
		{
			assets = Assets.instance.getAssetsManager( Assets.MAIN_UI );
			menu = new Dictionary();
			initBG();
			initHeadImage();
			initBtnSound();
			initMenu();
		}
		
		private function initBtnSound():void
		{
		}
		
		private function initMenu():void
		{
			const names:Array = [
				ScreenCode.GAME_LIST,		//游戏列表
				ScreenCode.BOARD,			//your board
				ScreenCode.MAP,				//主页面
				ScreenCode.PARENTS			//父母登陆页面
			];
			
			var btn:Button;
			var name:String;
			for(var i:int = 0;i<names.length;i++)
			{
				name = names[i];
				btn = new Button( assets.getTexture( "ui_btn_" + name ) );
				btn.name = name;
				btn.x = 370 + (btn.width+ 20)*i;
				btn.y = 60;
				this.addChild( btn );
				btn.addEventListener( Event.TRIGGERED, onTriggered);
				menu.name = btn;
			}
		}
		private function onTriggered(e:Event):void
		{
			var btn:Button = e.target as Button;
			trace(btn.name);
			MC.instance.openScreen( btn.name );
		}
		
		private function initHeadImage():void
		{
			head = Assets.getImage( assets, "headIcon_0" );
			this.addChild( head );
			head.touchable = false;
			head.x = 49;
			head.y = 18;
			head.width = head.height = 80;
		}
		
		private function initBG():void
		{
			bg = Assets.getImage( assets, "UIboard" );
			bg.pivotY = 6;
			this.addChild( bg );
			bg.addEventListener( TouchEvent.TOUCH, onTouch );
			
		}
		
		private var startY:int;
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch( bg );
			if(touch)
			{
				switch(touch.phase)
				{
					case TouchPhase.BEGAN:
						startY = touch.getLocation( this ).y;
						break;
					case TouchPhase.ENDED:
						var crtY:int = touch.getLocation( this ).y;
						trace(startY, crtY);
						if(crtY - startY >= 0)		//下拉
							show();
						else if(crtY - startY <= 0)	//上移
							hide();
						break;
				}
			}
		}
		
		private var isHide:Boolean = false;
		private var targetY:int = -104;
		private function show():void
		{
			if(!isHide)
				return;
			bg.touchable = false;
			TweenLite.to( this, .5, { y: 0, ease:Cubic.easeOut, onComplete: function():void{
				isHide = false;
				bg.touchable = true;
				trace(isHide);
			}});
		}
		private function hide():void
		{
			if(isHide)
				return;
			bg.touchable = false;
			TweenLite.to( this, .5, { y: targetY, ease:Cubic.easeOut, onComplete: function():void{
				isHide = true;
				bg.touchable = true;
				trace(isHide);
			}});
		}
	}
}