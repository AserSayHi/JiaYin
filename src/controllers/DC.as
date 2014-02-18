package controllers
{
	import com.pamakids.utils.Singleton;

	import models.SOService;

	/**
	 * 数据中心，除了本地数据缓存之外也包括同服务器通信
	 * @author mani
	 */
	public class DC extends Singleton
	{

		private var so:SOService;

		public var taskes:Array;

		public function DC()
		{
			so=SOService.instance;
		}

		public static function get instance():DC
		{
			return Singleton.getInstance(DC);
		}
	}
}
