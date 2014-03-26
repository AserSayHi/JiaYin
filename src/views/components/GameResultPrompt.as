package views.components
{
	import utils.StarlingAssets;
	
	import models.GameResultVO;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class GameResultPrompt extends Sprite
	{
		private static var _instance:GameResultPrompt;
		
		public static function get instance():GameResultPrompt
		{
			if(!_instance)
			{
				_instance = new GameResultPrompt();
			}
			return _instance;
		}
		
		public function GameResultPrompt()
		{
			init();
		}
		
		private var assets:AssetManager;
		private var btn_restart:Button;
		private var btn_end:Button;
		private var stars:Vector.<Image>;
		
		private function init():void
		{
			assets = StarlingAssets.instance.getAssetsManager( StarlingAssets.Games );
			initBG();
			initBtn();
			initStars();
		}
		
		private function initBG():void
		{
		}
		
		private function initStars():void
		{
			tLight = assets.getTexture( "" );
			tBlack = assets.getTexture( "" );
			
			var star:Image;
			stars = new Vector.<Image>(3);
			for(var i:int = 0;i<stars.length;i++)
			{
				star = new Image( tBlack );
				this.addChild( star );
				star.touchable = false;
				stars[i] = star;
			}
		}
		
		private var tLight:Texture;
		private var tBlack:Texture;
		
		public function show(vo:GameResultVO):void
		{
			var numStars:int = vo.starNum;
			update(numStars);
		}
		
		private function update(numStars:int):void
		{
			for(var i:int = 0;i<stars.length;i++)
			{
				stars[i].texture = (i>=numStars-1) ? tBlack : tLight;
			}
		}
		
		private function initBtn():void
		{
			btn_restart = new Button( assets.getTexture("") );
			this.addChild( btn_restart );
			btn_restart.addEventListener(Event.TRIGGERED, onTriggered );
			
			btn_end = new Button( assets.getTexture( "" ) );
			this.addChild( btn_end );
			btn_end.addEventListener(Event.TRIGGERED, onTriggered );
		}
		
		private function onTriggered(e:Event):void
		{
			switch(e.target)
			{
				case btn_restart:		//游戏重新开始
					break;
				case btn_end:			//游戏结束
					break;
			}
		}
		
		override public function dispose():void
		{
			this.assets = null;
			this.tBlack = this.tLight = null;
			this.btn_restart.removeEventListener(Event.TRIGGERED, onTriggered);
			this.btn_restart.removeFromParent( true );
			this.btn_restart = null;
			this.btn_end.removeEventListener(Event.TRIGGERED, onTriggered);
			this.btn_end.removeFromParent( true );
			this.btn_end = null;
			for each(var star:Image in stars)
			{
				star.removeFromParent( true );
			}
			stars = null;
			super.dispose();
		}
	}
}