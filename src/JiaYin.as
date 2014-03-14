package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	
	import models.PosVO;
	
	import starling.core.Starling;
	
	public class JiaYin extends Sprite
	{
		public function JiaYin()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			PosVO.init( stage.fullScreenWidth, stage.fullScreenHeight, 1280, 960 );
			trace("===================运行环境=========================");
			trace("设备屏幕尺寸： width = " + stage.fullScreenWidth + ", height = " + stage.fullScreenHeight);
			trace("虚拟视窗尺寸: width = "+PosVO.LOGIC_WIDTH+", height = "+PosVO.LOGIC_HEIGHT);
			trace("实际显示尺寸: width = "+PosVO.REAL_WIDTH+", height = "+PosVO.REAL_HEIGHT);
			trace("缩放比： scale = " + PosVO.scale + ", offsetX = " + PosVO.OffsetX + ", offsetY = " + PosVO.OffsetY);
			trace("==================================================");
			
			var rect:Rectangle = new Rectangle(PosVO.OffsetX, PosVO.OffsetY, 
				PosVO.LOGIC_WIDTH * PosVO.scale, 
				PosVO.LOGIC_HEIGHT * PosVO.scale);
			s = new Starling(Main, stage);
			s.stage.stageWidth = PosVO.LOGIC_WIDTH * PosVO.scale;
			s.stage.stageHeight = PosVO.LOGIC_HEIGHT * PosVO.scale;
			s.viewPort = rect;
			s.showStats = true;
			s.showStatsAt("left", "center");
			s.enableErrorChecking = true;
			s.start();
		}
		private var s:Starling;
	}
}