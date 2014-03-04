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
		
		public function getData(code:String):Object
		{
			return null;
		}
		
		public function checkLocalData(code:String):Boolean
		{
			return (so.data[code] != null);
		}
		
		public function save(code:String, obj:Object):void
		{
			so.data[code] = obj;
			so.flush();
		}
	}
}
