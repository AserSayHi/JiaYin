package utils
{
	import com.pamakids.iflytek.controllers.Recognizer;
	import com.pamakids.iflytek.controllers.Recorder;
	import com.pamakids.iflytek.event.IFlytekRecogEvent;
	import com.pamakids.utils.Singleton;
	
	public class Voice extends Singleton
	{
		public static const RECOGNIZER:String = "recognizer";
		public static const RECORDER:String = "recorder";
		
		public static function get instance():Voice
		{
			return Singleton.getInstance( Voice );
		}
		
		private var _recognizer:Recognizer;
		private function get recognizer():Recognizer
		{
			if(!_recognizer)
				_recognizer = new Recognizer();
			return _recognizer;
		}
		
		private var _recorder:Recorder;
		private function get recorder():Recorder
		{
			if(!_recorder)
				_recorder = new Recorder();
			return _recorder;
		}
		
		public function initRecognizer(initSuccess:Function=null, initFailed:Function=null):void
		{
			var recog:Recognizer = recognizer;
			this.initSuccess = initSuccess;
			this.initFailed = initFailed;
			if( recog.checkInitialized() )
			{
				if(initSuccess)
					initSuccess();
				this.initSuccess = null;
				this.initFailed = null;
				return;
			}
			
			recog.addEventListener(IFlytekRecogEvent.INITIALIZE_SUCCESS, recogHandler);
			recog.addEventListener(IFlytekRecogEvent.INITIALIZE_FAILED, recogHandler);
			recog.addEventListener(IFlytekRecogEvent.INITGRAMMER_SUCCESS, recogHandler);
			recog.addEventListener(IFlytekRecogEvent.INITGRAMMER_FAILED, recogHandler);
			recog.addEventListener(IFlytekRecogEvent.UPDATE_LEXCION_SUCCESS, recogHandler);
			recog.addEventListener(IFlytekRecogEvent.UPDATE_LEXCION_FAILED, recogHandler);
			recog.addEventListener(IFlytekRecogEvent.RECOG_BEGIN, recogHandler);
			recog.addEventListener(IFlytekRecogEvent.RECOG_END, recogHandler);
			recog.addEventListener(IFlytekRecogEvent.RECOG_ERROR, recogHandler);
			recog.addEventListener(IFlytekRecogEvent.RECOG_RESULT, recogHandler);
			recog.addEventListener(IFlytekRecogEvent.VOLUME_CHANGED, recogHandler);
			recog.initialize();
		}
		
		private var initSuccess:Function;
		private var initFailed:Function;
		private function recogHandler(e:IFlytekRecogEvent):void
		{
			switch(e.type)
			{
				case IFlytekRecogEvent.INITIALIZE_SUCCESS:
					trace("recognizer初始化完成");
					recognizer.initGrammar("assets/apk/call.bnf");
					break;
				case IFlytekRecogEvent.INITIALIZE_FAILED:
					trace("recog初始化失败，错误码： " + e.message);
					if(initFailed)
						initFailed();
					initFailed = null;
					initSuccess = null;
					break;
				case IFlytekRecogEvent.INITGRAMMER_SUCCESS:
					if(initSuccess)
						initSuccess();
					initSuccess = null;
					initFailed = null;
					trace("recog语法构建成功");
					break;
				case IFlytekRecogEvent.INITGRAMMER_FAILED:
					if(initFailed)
						initFailed();
					initFailed = null;
					initSuccess = null;
					trace("recog语法构建失败，错误码： " +　e.message);
					break;
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
					if(resultCallback)
						resultCallback( "" );
					resultCallback = null;
					break;
				case IFlytekRecogEvent.RECOG_RESULT:
					resultCallback( e.message );
					resultCallback = null;
					trace("获取识别结果，语音内容为：" + e.message);
					break;
				case IFlytekRecogEvent.VOLUME_CHANGED:
					trace("语音音量变化，当前音量值为：  " + e.message);
					break;
			}
		}
		
		private var resultCallback:Function;
		/**
		 * 开始识别，需传入用于接收识别结果字符串的方法，若识别失败则结果为null
		 * @param resultHandler
		 */		
		public function startRecognizer( resultHandler:Function ):void
		{
			resultCallback = resultHandler;
			_recognizer.startRecog();
		}
		
		/**
		 * 更新识别辞典，多个单词使用"_"分割
		 * @param words
		 */	
		public function updateRecognizerLexcion( words:String ):void
		{
			_recognizer.updateLexcion( "content", words );
		}
	}
}