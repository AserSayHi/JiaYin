package views.components
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * flash原生显示对象容器
	 * @author kc2ong
	 */	
	public class Stage2D
	{
		private var local:Sprite;
		private var global:Sprite;
		private var main:Sprite;
		public function Stage2D(main:Sprite)
		{
			this.main = main;
			initialize();
		}
		
		private function initialize():void
		{
			local = new Sprite();
			main.addChild( local );
			
			global = new Sprite();
			global.x -= main.x;
			global.y -= main.y;
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
			if(!ifLocal)
				global.addChild( child );
			else
				local.addChild( child );
		}
	}
}