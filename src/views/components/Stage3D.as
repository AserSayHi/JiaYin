package views.components
{
	import models.PosVO;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class Stage3D
	{
		private var global:Sprite;
		private var local:Sprite;
		private var main:Sprite;
		
		public function Stage3D(main:Sprite)
		{
			this.main = main;
			initialize();
		}
		
		private function initialize():void
		{
			local = new Sprite();
			main.addChild( local );
			
			global = new Sprite();
			global.x = PosVO.LOGIC_WIDTH - PosVO.REAL_WIDTH >> 1;
			global.y = PosVO.LOGIC_HEIGHT - PosVO.REAL_HEIGHT >> 1;
			main.addChild( global );
		}	
		/**
		 * 以设备左上角为原点的容器，位于local容器上层
		 * @return 
		 */		
		public function get globalContainer():Sprite
		{
			return global;
		}
		
		/**
		 * 以虚拟视窗左上角顶点为原点的容器
		 * @return 
		 */		
		public function get localContainer():Sprite
		{
			return local;
		}
		
		/**
		 * @param child 
		 * @param ifLocal 指定对象当前坐标为局部坐标，若值为flase，则对象是以设备左上角为原点
		 */
		public function addChild(child:DisplayObject, ifLocal:Boolean=false):void
		{
			if(ifLocal)
				local.addChild( child );
			else
				global.addChild( child );
		}
	}
}