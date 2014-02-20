package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import models.PosVO;
	
	import starling.core.Starling;
	
	[SWF(width="1024", height="768", frameRate="30", backgroundColor="0x554040")]
	public class JiaYin extends Sprite
	{
		public function JiaYin()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			PosVO.init(stage.fullScreenWidth, stage.fullScreenHeight);
			
			var scale:Number = PosVO.scale;
			this.scaleX = this.scaleY = scale;
			this.x = PosVO.OffsetX;
			this.y = PosVO.OffsetY;
			
			
			
			initStarling();
		}
		
		private function initStarling():void
		{
			star = new Starling(Main, stage);
			star.start();
		}
		private var star:Starling;
	}
}