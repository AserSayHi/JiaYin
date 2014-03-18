package views.games
{
	import com.pamakids.iflytek.event.IFlytekRecogEvent;
	
	import models.PosVO;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class Game_RunStop extends BasicGame
	{
		public function Game_RunStop()
		{
			super();
		}
		
		override protected function initHandler():void
		{
			setGameBG( assets.getTexture( "mainBG" ));
			initImage();
			initCompleted();
		}
		
		private function recogHandler(e:IFlytekRecogEvent):void
		{
			switch(e.type)
			{
				case IFlytekRecogEvent.UPDATE_LEXCION_SUCCESS:
					trace("recognizer词典更新成功");
					break;
				case IFlytekRecogEvent.UPDATE_LEXCION_FAILED:
					trace("recognizer词典更新失败，错误码： " + e.message);
					break;
				case IFlytekRecogEvent.RECOG_BEGIN:
					trace("语音识别开始！");
					break;
				case IFlytekRecogEvent.RECOG_END:
					trace("语音识别结束！");
					break;
				case IFlytekRecogEvent.RECOG_ERROR:
					trace("识别出错，错误码： " + e.message);
					break;
				case IFlytekRecogEvent.RECOG_RESULT:
					trace("获取识别结果，语音内容为：" + e.message);
					break;
				case IFlytekRecogEvent.VOLUME_CHANGED:
					trace("语音音量变化，当前音量值为：  " + e.message);
					break;
			}
		}
		
		private var image_run:Image;
		private var image_run_light:Texture;
		private var image_run_black:Texture;
		private var image_stop:Image;
		private var image_stop_light:Texture;
		private var image_stop_black:Texture;
		private function initImage():void
		{
			var image:Image = getImage( "image_other_0" );
			this.addChild( image );
			image.x = PosVO.REAL_WIDTH - image.width;
			image.y = 50;
			
			image_run_light = assets.getTexture( "btn_run_down" );
			image_run_black = assets.getTexture( "btn_run_up" );
			image_stop_light = assets.getTexture( "btn_stop_down" );
			image_stop_black = assets.getTexture( "btn_stop_up" );
			
			image_stop = new Image( image_stop_black );
			image_stop.x = PosVO.REAL_WIDTH - 372;
			image_stop.y = 15;
			this.addChild( image_stop );
			
			image_run = new Image( image_run_black );
			image_run.x = PosVO.REAL_WIDTH - 180;
			image_run.y = 36;
			this.addChild( image_run );
			
			image.touchable = image_run.touchable = image_stop.touchable = false;
		}
		
		override public function start():void
		{
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
	}
}