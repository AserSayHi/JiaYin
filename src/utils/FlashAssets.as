package utils
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	/**
	 * flash原生动画管理类，用于处理swf文件加载以及获取swf中的mc的实例对象
	 * @author kc2ong
	 */	
	public class FlashAssets
	{
		/**
		 * 用于加载游戏中随时会使用到的全局性原生动画效果
		 */		
		public static const GLOBAL:String = "global";
		/**
		 * 用于加载单一游戏中独有的动画资源
		 */		
		public static const GAMES:String = "games";
		
		private static var dic:Dictionary = new Dictionary();
		public static function getInstance(title:String):FlashAssets
		{
			if(!dic[title])
				dic[title] = new FlashAssets(new MyClass());
			return dic[title];
		}
		
		public static function delInstance(title:String):void
		{
			var f:FlashAssets = dic[title];
			if(!f)
				return;
			delete dic[title];
			f.dispose();
		}
		
		public static function checkInitialized(title:String):Boolean
		{
			return dic[title] != null;
		}
		
		public function FlashAssets(myClass:MyClass)
		{
			super();
		}
		
		private var loader:Loader;
		public function loadSWF(URL:String, complete:Function=null):void
		{
			trace("开始加载文件："+URL);
			if(!loader)
				initLoader();
			onComplete = complete;
			loader.load( new URLRequest(URL) );
		}
		private var onComplete:Function;
		
		private function initLoader():void
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onLoader );
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoader );
		}
		
		protected function onLoader(e:Event):void
		{
			switch(e.type)
			{
				case ProgressEvent.PROGRESS:
					var loaderInfo:LoaderInfo = e.target as LoaderInfo;
					trace("加载进度： " + loaderInfo.bytesLoaded + "/" + loaderInfo.bytesTotal);
					break;
				case Event.COMPLETE:
					if(onComplete)
						onComplete();
					onComplete = null;
					trace("loaded");
					break;
			}
		}
		
		public function getMovieClipByName(name:String):Object
		{
			if(loader)
			{
				var c:Class = loader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
				if(c)
					return new c();
			}
			return null;
		}
		
		/**
		 * 清除加载的swf以释放内存
		 */		
		public function dispose():void
		{
			if(loader)
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoader);
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoader);
				loader.unload();
				loader = null;
			}
		}
	}
}

class MyClass{}