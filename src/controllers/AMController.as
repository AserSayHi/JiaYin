package controllers
{
	import com.pamakids.utils.Singleton;
	
	import flash.utils.Dictionary;
	
	import starling.utils.AssetManager;

	/**
	 * AssetsManager Controller
	 * @author Administrator
	 */	
	public class AMController extends Singleton
	{
		protected var _dic:Dictionary = new Dictionary(true);
		
		public function get instance():AMController
		{
			return Singleton.getInstance(AMController);
		}
		
		public function getAssetsManager(name:String):AssetManager
		{
			if(!_dic[name])
			{
				var am:AssetManager = new AssetManager();
				_dic[name] = am;
			}
			return am;
		}
		
		public function delAssetsManager(name:String):void
		{
			if(_dic[name])
			{
				_dic[name].dispose();
				delete _dic[name];
			}
		}
		
		public function checkAssetsManagerByName(name:String):Boolean
		{
			return (_dic[name] != null);
		}
		
		public function dispose():void
		{
			for(var name:String in _dic)
			{
				delAssetsManager(name);
			}
		}
	}
}