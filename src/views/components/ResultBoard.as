package views.components
{
	import controllers.MC;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	import utils.StarlingAssets;
	import utils.StatusManager;
	
	import views.games.BasicGame;
	
	public class ResultBoard extends Sprite
	{
		public function ResultBoard()
		{
			super();
			
			init();
		}
		
		private var assets:AssetManager;
		private var BG:Image;
		private var stars:Vector.<Image>;
		
		private var starLight:Texture;
		private var starBlack:Texture;
		
		private var btn_replay:Button;		//50,275
		private var btn_continue:Button;	//300, 275
		
		private function init():void
		{
			assets = StarlingAssets.instance.getAssetsManager(StarlingAssets.Games);
			
			BG = new Image( assets.getTexture("image_other_board") );
			this.addChild( BG );
			
			stars = new Vector.<Image>(3);
			starBlack = assets.getTexture("image_star_black");
			starLight = assets.getTexture("image_star_light");
			
			//位置与角度配置
			var position:Array = [
				{x: 104, y:128, rotation: 1},
				{x: 224, y:104, rotation: 0},
				{x: 344, y:128, rotation: -1}
			];
			var star:Image;
			var obj:Object;
			for(var i:int = 0;i<3;i++)
			{
				star = new Image( starBlack );
				star.pivotX = star.width >> 1;
				star.pivotY = star.height >> 1;
				star.touchable = false;
				this.addChild( star );
				if(i == 2)
					this.swapChildren( star, stars[1]);
				stars[i] = star;
				
				obj = position[i];
				star.x = obj.x;
				star.y = obj.y;
				star.rotation = obj.rotation;
			}
			
			btn_replay = new Button( assets.getTexture("btn_replay") );
			btn_replay.x = 50;
			btn_replay.y = 275;
			this.addChild( btn_replay );
			btn_replay.addEventListener( Event.TRIGGERED, onTriggered );
			
			btn_continue = new Button( assets.getTexture("btn_next") );
			btn_continue.x = 300;
			btn_continue.y = 275;
			this.addChild( btn_continue );
			btn_continue.addEventListener( Event.TRIGGERED, onTriggered );
		}
		
		private function onTriggered(e:Event):void
		{
			var game:BasicGame = MC.instance.getGameController().getCrtGame();
			switch(e.target)
			{
				case btn_replay:
					game.restart();
					break;
				case btn_continue:
					game.end();
					break;
			}
		}
		
		public function showStars(num:int):void
		{
			var star:Image;
			for(var i:int = 0;i<3;i++)
			{
				star = stars[i];
				if(i<num)
					star.texture = starLight;
				else
					star.texture = starBlack;
				star.alpha = 0;
			}
			
			StatusManager.getInstance().addFunc( 
				function():void{
					var image:Image;
					for(var j:int = 0;j<3;j++)
					{
						image = stars[j];
						if(image.alpha >= 1)
							continue;
						image.alpha += .1;
						break;
					}
				}, 20, 30);
		}
		
		override public function dispose():void
		{
			starLight = null;
			starBlack = null;
			
			BG.removeFromParent(true);
			for each(var star:Image in stars)
			{
				star.removeFromParent( true );
			}
			stars = null;
			btn_replay.removeEventListener( Event.TRIGGERED, onTriggered );
			btn_replay.removeFromParent(true);
			btn_replay = null;
			btn_continue.removeEventListener( Event.TRIGGERED, onTriggered );
			btn_continue.removeFromParent( true );
			btn_continue = null;
			assets = null;
			super.dispose();
		}
	}
}