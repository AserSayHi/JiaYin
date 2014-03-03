package utils
{
	import com.pamakids.utils.Singleton;
	

	public class GameController extends Singleton
	{
		public static function instance():GameController
		{
			return Singleton.getInstance( GameController );
		}
		
		/**
		 * 时间进度控制器
		 */		
		private var status:StatusManager;
		
		public function GameController()
		{
			super();
			
			status = StatusManager.getInstance();
			status.initialize();
		}
		
		public function openGame(gameID:String):void
		{
		}
		
		public function closeCrtGame():void
		{
		}
		
		public function dispose():void
		{
			super.dispose();
		}
	}
}