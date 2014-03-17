package views.games
{
	import flash.geom.Point;
	
	import controllers.Assets;
	
	import models.PosVO;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.textures.Texture;

	public class Game_AppleBanana extends BasicGame
	{
		public function Game_AppleBanana()
		{
			super();
		}
		
		//override functions=============================================================
		override protected function initHandler():void
		{
			initBG();
			initTextures();
			initBtns();
			initialized();
		}
		
		private var btn_record:Button;
		private function initBtns():void
		{
			btn_record = new Button( assets.getTexture("guide_btn_record_up") );
			this.addChild( btn_record );
			btn_record.x = 40;
			btn_record.y = PosVO.REAL_HEIGHT - btn_record.height - 40;
		}
		
		private var texture_0:Texture;
		private var texture_1:Texture;
		private var textures:Vector.<Texture>;
		private function initTextures():void
		{
			var numFruits:int = 8;
			texture_0 = assets.getTexture( "icon_0" );
			texture_1 = assets.getTexture( "icon_1" );
			textures = new Vector.<Texture>();
			for(var i:int = 0; i<numFruits/2; i++)
			{
				textures.push( texture_0, texture_1 );
			}
		}
		
		private function initBG():void
		{
			setGameBG( assets.getTexture( "mainBG" ));
			var image:Image = Assets.getImage( assets, "image_other_0" );
			image.x = PosVO.REAL_WIDTH - image.width >> 1;
			image.y = 0;
			this.addChild( image );
			image.touchable = false;
			image = Assets.getImage( assets, "image_other_1" );
			image.x = PosVO.REAL_WIDTH - image.width >> 1;
			image.y = PosVO.REAL_HEIGHT - image.height;
			this.addChild( image );
			image.touchable = false;
		}
		
		private var crtTextures:Vector.<Texture>;

		override public function start():void
		{
			crtTextures = textures.slice();
			showIcon();
		}
		
		private var icon:Image;
		private function showIcon():void
		{
			if(crtTextures.length == 0)
			{
				end();
				return;
			}
			var r:int = Math.random() * crtTextures.length;
			var texture:Texture = crtTextures[r];
			crtTextures.splice(r,1);
			icon ? icon = new Image( texture ) : initIcon(texture);
			icon.scaleX = icon.scaleY = .2;
			statusM.addFunc( animationFunc, 50, 20, showRecordBtn );
		}
		
		private var count:int = 0;
		private function animationFunc():void
		{
			var target:Number = 1.8;	//缩放目标值
			var spring:Number = .95;		//弹性系数
			var friction:Number = 1.6;	//摩擦系数
			var vs:Number = ( target-icon.scaleX ) * spring;
			icon.scaleX += ( vs*friction );
			icon.scaleY += ( vs*friction );
		}
		
		private function showRecordBtn():void
		{
			
		}
		
		private function initIcon(texture:Texture):void
		{
			icon = new Image( texture );
			icon.pivotX = icon.width >> 1;
			icon.pivotY = icon.height >> 1;
			this.addChild( icon );
			icon.touchable = false;
			icon.x = PosVO.REAL_WIDTH >> 1;
			icon.y = (PosVO.REAL_HEIGHT >> 1) - 100;
		}
		
		override public function dispose():void
		{
		}
	}
}