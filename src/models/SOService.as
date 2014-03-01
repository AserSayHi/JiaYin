package models
{
	import com.pamakids.utils.Singleton;
	
	import flash.net.SharedObject;

	/**
	 *
	 * @author Administrator
	 */
	public class SOService extends Singleton
	{
		public function SOService(myClass:MyClass)
		{
			init();
		}

		public function init():void
		{
			so=SharedObject.getLocal("");
		}
		
		private var so:SharedObject;

		/**
		 * @return
		 */
		public static function get instance():SOService
		{
			return Singleton.getInstance(SOService);
		}

		/**
		 * 
		 */
		public function clear():void
		{
			so.clear();
		}

		/**
		 * 将日期转化为字符串表示形式，所获取的字符串格式如： 2014-12-31
		 */		
		public static function dateToString(date:Date):String
		{
			var str:String=date.fullYear.toString();
			var s:String=date.month.toString();
			if (s.length == 1)
				s="0" + s;
			str+=("-" + s);
			s=date.date.toString();
			if (s.length == 1)
				s="0" + s;
			str+=("-" + s);
			return str;
		}
		
		/**
		 * 将字符串格式日期转化为date，字符串格式如： 2014-12-31
		 */		
		public static function StringToDate(date:String):Date
		{
			var arr:Array=date.split("-");
			return new Date(arr[0], int(arr[1]) - 1, arr[2]);
		}
	}
}

class MyClass{}
