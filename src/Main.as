package
{
	import com.pamakids.iflytek.event.IFlytekServiceEvent;
	import com.pamakids.iflytek.utils.ApkInstall;
	
	import flash.events.Event;
	
	import controllers.DC;
	import controllers.MC;
	
	import starling.display.Sprite;
	
	import utils.StatusManager;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			super();
			
			initialize();
		}
		
		private function initialize(e:Event=null):void
		{
			var apkInstall:ApkInstall = ApkInstall.instance();
			
			//是否安装了讯飞语音+
			if(!apkInstall.checkServiceInstall())
			{
				apkInstall.addEventListener(Event.ACTIVATE, initialize);
				apkInstall.addEventListener(IFlytekServiceEvent.INSTALL_SERVICE_FAILED, onInstallFailed);
				//安装讯飞语音+
				apkInstall.installService("assets/iflytek/SpeechService_1.0.1063.mp3");
			}
			else
			{
				if(apkInstall.hasEventListener(IFlytekServiceEvent.INSTALL_SERVICE_FAILED))
					apkInstall.removeEventListener(IFlytekServiceEvent.INSTALL_SERVICE_FAILED, onInstallFailed);
				if(apkInstall.hasEventListener(Event.ACTIVATE))
					apkInstall.removeEventListener(Event.ACTIVATE, initialize);
				
				initGame();
			}
		}
		private function onInstallFailed(e:IFlytekServiceEvent):void
		{
			trace("讯飞语音+ 安装失败！");
		}
		
		//游戏初始化
		private function initGame():void
		{
			StatusManager.getInstance().initialize();
			DC.instance.initialize();
			MC.instance.initialize(this);
		}
	}
}