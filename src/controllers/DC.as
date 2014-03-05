package controllers
{
	import com.pamakids.utils.Singleton;
	
	import flash.net.SharedObject;


	/**
	 * 数据中心，除了本地数据缓存之外也包括同服务器通信
	 * @author mani
	 */
	public class DC extends Singleton
	{
		public static function get instance():DC
		{
			return Singleton.getInstance(DC);
		}
		
		private var so:SharedObject;
		
		public function initialize():void
		{
			so = SharedObject.getLocal("Local");
		}
		
		/**
		 * 获取本地的缓存数据
		 * @param code	数据编码，由SoCode类静态常量定义
		 */		
		public function getData(code:String):Object
		{
			return null;
		}
		
		/**
		 * 检测本地中是否有相应缓存数据
		 * @param code	数据编码，由SoCode类静态常量定义
		 */		
		public function checkLocalData(code:String):Boolean
		{
			return (so.data[code] != null);
		}
		
		/**
		 * 将数据存入本地
		 * @param code	数据编码，由SoCode类静态常量定义
		 * @param data	数据
		 * 
		 */		
		public function save(code:String, data:Object):void
		{
			so.data[code] = data;
			so.flush();
		}
	}
}
