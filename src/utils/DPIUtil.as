package utils
{
	import flash.system.Capabilities;

	public class DPIUtil
	{
		/**
		 *  Density value for low-density devices.
		 */
		public static const DPI_160:Number=160;

		/**
		 *  Density value for medium-density devices.
		 */
		public static const DPI_240:Number=240;

		/**
		 *  Density value for high-density devices.
		 */
		public static const DPI_320:Number=320;

		public function DPIUtil()
		{
		}

		public static function getRuntimeDPI():Number
		{
			var dpi:Number=Capabilities.screenDPI;
//			return 169;
			if (Capabilities.screenResolutionX > 2000 || Capabilities.screenResolutionY > 2000)
				return DPI_320;
			if (dpi < 200)
				return DPI_160;
			if (dpi <= 280)
				return DPI_240;
			return DPI_320;
		}

		public static function getDPIScale(sourceDPI:Number=160):Number
		{
			var targetDPI:Number=getRuntimeDPI();
			// Unknown dpi returns NaN
			if ((sourceDPI != DPI_160 && sourceDPI != DPI_240 && sourceDPI != DPI_320) ||
				(targetDPI != DPI_160 && targetDPI != DPI_240 && targetDPI != DPI_320))
			{
				return 1;
			}

			return targetDPI / sourceDPI;
		}

		/**
		 * array[scale, offsetX, offsetY, realWidth, realHeight]
		 * */
		public static function getAndroidSize(sx:Number, sy:Number, logicW:uint, logicH:uint):Array
		{
			const LogicWidth:uint = logicW;
			const LogicHeight:uint = logicH;
			
			var w:int  = Math.max( sx, sy );
			var h:int = Math.min( sx, sy );
			
			var scale:Number=0;
			var offsetX:Number=0
			var offsetY:Number=0;
			var realWidth:Number = 0;
			var realHeight:Number = 0;
			if (h / LogicHeight > w / LogicWidth)
			{
				scale= h / LogicHeight;
				offsetX=(w - LogicWidth * scale) / 2;
				realHeight = LogicHeight;
				realWidth = Math.round( w / scale );
				if(realWidth%2 == 1)
					realWidth += 1;
			}
			else
			{
				scale=w / LogicWidth;
				offsetY=(h - LogicHeight * scale) / 2;
				realWidth = LogicWidth
				realHeight = Math.round( h / scale );
				if(realHeight%2 == 1)
					realHeight += 1;
			}
			return [scale, offsetX, offsetY, realWidth, realHeight];
		}

	}
}
