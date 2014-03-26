package utils
{
	import com.pamakids.utils.Singleton;
	
	import flash.utils.Dictionary;
	
	import starling.utils.AssetManager;

	/**
	 * AssetsManager Controller
	 * @author Administrator
	 */	
	public class StarlingAssets extends Singleton
	{
		public static const SCREEN:String = "mainUI";
		public static const Games:String = "games";
		
		protected var _dic:Dictionary = new Dictionary();
		
		public static function get instance():StarlingAssets
		{
			return Singleton.getInstance(StarlingAssets);
		}
		
		public function getAssetsManager(name:String):AssetManager
		{
			if(!_dic.hasOwnProperty(name))
				_dic[name] = new AssetManager();
			return _dic[name];
		}
		
		public function delAssetsManager(name:String):void
		{
			if(_dic.hasOwnProperty(name))
			{
				_dic[name].purge()
				delete _dic[name];
			}
		}
		
		public function checkAssetsManagerByName(name:String):Boolean
		{
			return _dic.hasOwnProperty(name);
		}
		
		public function delAll():void
		{
			for(var name:String in _dic)
			{
				delAssetsManager(name);
			}
		}
		
	}
}