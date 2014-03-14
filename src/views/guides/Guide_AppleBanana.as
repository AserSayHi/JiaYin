package views.guides
{
	import events.GuideEvent;
	
	import models.PosVO;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;

	public class Guide_AppleBanana extends BasicGuide
	{
		public function Guide_AppleBanana()
		{
			super();
		}
		
		override protected function initHandler():void
		{
			setBG(assets.getTexture( "guide_mainBG"　));
			initImage();
			initBTNs();
		}
		
		private var bgs:Vector.<Texture>;
		private var icons:Vector.<Texture>;
		private var mask:Image;
		private var iconBG:Image;
		private var icon:Image;
		
		private function initImage():void
		{
			var texture:Texture;
			bgs = new Vector.<Texture>();
			for(var i:int = 0;i<int.MAX_VALUE;i++)
			{
				texture = assets.getTexture("guide_image_bg_"+i);
				if(!texture)
					break;
				bgs.push( texture );
			}
			
			icons = new Vector.<Texture>();
			for(i=0;i<int.MAX_VALUE;i++)
			{
				texture = assets.getTexture( "guide_icon_" + i );
				if(!texture)
					break;
				icons.push( texture );
			}
			
			mask = new Image( assets.getTexture("guide_image_other_0"));
			mask.pivotX = mask.width >> 1;
			mask.pivotY = mask.height >> 1;
			mask.x = PosVO.REAL_WIDTH >> 1;
			mask.y = 30 + mask.pivotY ;
			
			iconBG = new Image( bgs[0] );
			iconBG.pivotX = iconBG.width >> 1;
			iconBG.pivotY = iconBG.height >> 1;
			iconBG.x = mask.x - 4;
			iconBG.y = mask.y - 4;
			mask.touchable = iconBG.touchable = false;
			this.addChild( iconBG );
			this.addChild( mask );
			
			icon = new Image(icons[0]);
			this.addChild( icon );
			icon.pivotX = icon.width >> 1;
			icon.pivotY = icon.height;
			icon.touchable = false;
			icon.x = PosVO.REAL_WIDTH >> 1;
			icon.y = mask.y + 160;
			
			mask.scaleX = mask.scaleY = iconBG.scaleX = iconBG.scaleY= icon.scaleX = icon.scaleY = .8;
		}
		
		private var btn_record:Button;
		private var btn_play:Button;
		private function initBTNs():void
		{
			btn_record = new Button( assets.getTexture("guide_btn_record_up") );
			this.addChild( btn_record);
			btn_record.x = 20;
			btn_record.y = PosVO.REAL_HEIGHT - btn_record.height - 20;
			btn_record.addEventListener( Event.TRIGGERED, onTriggered );
			
			btn_play = new Button( assets.getTexture("guide_btn_play_up") );
			this.addChild( btn_play);
			btn_play.x = PosVO.REAL_WIDTH - btn_play.width - 20;
			btn_play.y = 20;
			btn_play.addEventListener( Event.TRIGGERED, onTriggered );
		}
		
		private function onTriggered(e:Event):void
		{
			switch(e.target)
			{
				case btn_record:		//录音，是被
					
					break;
				case btn_play:			//播放
					
					break;
			}
		}
		
		override protected function startGuide():void
		{
		}
		
		override protected function onStepChanged(e:GuideEvent):void
		{
			switch(e.crtStep)
			{
				case 0:
					break;
				case 1:
					break;
				case 2:
					break;
			}
		}
		
		
		override public function dispose():void
		{
			
			super.dispose();
		}
	}
}