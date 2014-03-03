package models
{
	import utils.DPIUtil;
	
	public class PosVO
	{
		/** 设备实际显示像素宽度，为设备等比宽度，非设备屏幕宽度*/
		public static function get REAL_WIDTH():uint
		{
			return real_W;
		}
		/** 设备实际显示像素高度，为设备等比高度，非设备屏幕高度 */
		public static function get REAL_HEIGHT():uint
		{
			return real_H;
		}
		/** 虚拟视窗宽度 */
		public static function get LOGIC_WIDTH():uint
		{
			return logic_W;
		}
		/** 虚拟视窗宽度 */
		public static function get LOGIC_HEIGHT():uint
		{
			return logic_H;
		}
		
		private static var logic_W:uint;
		private static var logic_H:uint;
		private static var real_W:uint;
		private static var real_H:uint;
		private static var offsetX:Number;
		private static var offsetY:Number;
		private static var Scale:Number;

		public static function init(sx:Number, sy:Number, logicW:uint, logicH:uint):void
		{
			var w:Number = Math.max( sx, sy );
			var h:Number = Math.min( sx, sy );
			var arr:Array = DPIUtil.getAndroidSize(w, h, logicW, logicH);
			
			Scale = arr[0];
			offsetX = arr[1];
			offsetY = arr[2];
			
			logic_W = logicW;
			logic_H = logicH;
			
			real_W = arr[3];
			real_H = arr[4];
//			real_W = Math.min( logic_W, Math.round( w/Scale ) );
//			if(real_W%2 == 1)
//				real_W += 1;
//			real_H = Math.min( logic_H, Math.round( h/Scale ) );
//			if(real_H%2 == 1)
//				real_H += 1;
		}

		public static function get scale():Number
		{
			return Scale;
		}

		public static function get OffsetX():Number
		{
			return offsetX;
		}

		public static function get OffsetY():Number
		{
			return offsetY;
		}
	}
}
