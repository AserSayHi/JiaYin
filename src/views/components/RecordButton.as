package views.components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import utils.FlashAssets;
	import utils.Voice;

	/**
	 * 识别按钮控件
	 * @author kc2ong
	 */	
	public class RecordButton extends Sprite
	{
		public function RecordButton()
		{
			init();
		}
		
		private var mc:MovieClip;
		
		private function init():void
		{
			mc = FlashAssets.getInstance( FlashAssets.GLOBAL).getMovieClipByName( "btn_record" ) as MovieClip;
			this.addChild( mc );
			mc.addEventListener(MouseEvent.MOUSE_DOWN, onTriggered);
			mc.addEventListener(MouseEvent.MOUSE_UP, onTriggered);
			mc.gotoAndStop(1);
		}
		
//		private var recording:Boolean = false;
		private function onTriggered(e:MouseEvent):void
		{
//			if(recording)
//				return;
			switch(e.type)
			{
				case MouseEvent.MOUSE_DOWN:		//开始识别
					if(startHandler)
						startHandler();
					Voice.instance.startRecognizer( onResult );
					mc.gotoAndStop(2);
					trace("开始时间：" + getTimer());
					break;
				case MouseEvent.MOUSE_UP:		//结束等待结果
//					recording = true;
					Voice.instance.stopRecognizer();
					mc.gotoAndStop(1);
					break;
			}
		}
		
		private function onResult(result:String):void
		{
			trace("result =" + result);
//			recording = false;
			if(resultHandler)
				resultHandler( result );
		}
		
		private var resultHandler:Function;
		private var startHandler:Function;
		public function setResultFunction(resultHandler:Function, startHandler:Function=null):void
		{
			this.resultHandler = resultHandler;
			this.startHandler = startHandler;
		}
		
		public function dispose():void
		{
			if(mc)
			{
				mc.stop()
				if(mc.parent)
					mc.parent.removeChild( mc );
				mc = null;
			}
			resultHandler = null;
		}
	}
}