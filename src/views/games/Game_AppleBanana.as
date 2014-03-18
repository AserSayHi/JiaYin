package views.games
{
	import flash.filesystem.File;
	
	import models.PosVO;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	import utils.Voice;
	
	import views.components.RecordButton;

	public class Game_AppleBanana extends BasicGame
	{
		public function Game_AppleBanana()
		{
			super();
		}
		
		//override functions=============================================================
		override protected function initHandler():void
		{
			if(!controller.checkIfGuide())
			{
				assets.enqueue( File.applicationDirectory.resolvePath("assets/games/animation/record") );
				assets.loadQueue(function(r:Number):void{
					if(r == 1)
						init();
				});
			}else
			{
				init();
			}
		}
		
		private function init():void
		{
			initBG();
			initTextures();
			initBtns();
			//初始化时别控件，并更新词库
			Voice.instance.initRecognizer( initCompleted );
			Voice.instance.updateRecognizerLexcion("apple_banana_a_b");
		}
		
		private var btn_record:RecordButton;
		private function initBtns():void
		{
			btn_record = new RecordButton();
			btn_record.setResultFunction( onResult );
			this.addChild( btn_record );
			btn_record.x = 40;
			btn_record.y = PosVO.REAL_HEIGHT - btn_record.height - 40;
			btn_record.visible = false;
		}
		
		private var textures:Object;
		private function initTextures():void
		{
			var numFruits:int = 8;
			var texture_0:Texture = assets.getTexture( "icon_apple" );
			var texture_1:Texture = assets.getTexture( "icon_banana" );
			textures = new Vector.<Texture>();
			for(var i:int = 0; i<numFruits/2; i++)
			{
				textures.push( texture_0, texture_1 );
			}
		}
		
		//初始化背景图片
		private function initBG():void
		{
			setGameBG( assets.getTexture( "mainBG" ));
			var image:Image = getImage( "image_other_0" );
			image.x = PosVO.REAL_WIDTH - image.width >> 1;
			image.y = 0;
			this.addChild( image );
			image.touchable = false;
			image = getImage( "image_other_1" );
			image.x = PosVO.REAL_WIDTH - image.width >> 1;
			image.y = PosVO.REAL_HEIGHT - image.height;
			this.addChild( image );
			image.touchable = false;
		}
		private var crtTextures:Vector.<Texture>;

		override public function start():void
		{
			btn_record.visible = true;
			crtTextures = textures.slice();
			showIcon();
		}
		
		private function onResult(result:String):void
		{
			trace(result);
			if(!result)
			{
				recogFailed();
				return;
			}
			var texture:Texture = icon.texture;
			if(texture == assets.getTexture("icon_"+result))
			{
				recogSuccess();
			}else
			{
				recogFailed();
			}
		}
		//识别错误
		private function recogFailed():void
		{
			trace("错误");
		}
		//识别正确
		private function recogSuccess():void
		{
			trace("正确");
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
			super.dispose();
		}
	}
}