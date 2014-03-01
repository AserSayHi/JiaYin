package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import controllers.MC;
	
	import models.PosVO;
	
	import starling.core.Starling;
	
	public class JiaYin extends Sprite
	{
		public function JiaYin()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			PosVO.init( stage.fullScreenWidth, stage.fullScreenHeight );
			
			var rect:Rectangle = new Rectangle(PosVO.OffsetX, PosVO.OffsetY, 
				MC.LOGIC_WIDTH * PosVO.scale, 
				MC.LOGIC_HEIGHT * PosVO.scale);
			s = new Starling(Main, stage);
			s.stage.stageWidth = MC.LOGIC_WIDTH * PosVO.scale;
			s.stage.stageHeight = MC.LOGIC_HEIGHT * PosVO.scale;
			s.viewPort = rect;
			s.showStats = true;
			s.enableErrorChecking = true;
			s.start();
		}
		private var s:Starling;
	}
}