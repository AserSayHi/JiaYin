package controllers
{
	import com.pamakids.utils.Singleton;
	
	import flash.utils.Dictionary;
	
	import models.PosVO;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	/**
	 * AssetsManager Controller
	 * @author Administrator
	 */	
	public class Assets extends Singleton
	{
		public static const MAIN_UI:String = "mainUI";
		
		protected var _dic:Dictionary = new Dictionary();
		
		public static function get instance():Assets
		{
			return Singleton.getInstance(Assets);
		}
		
		public static function getImage(ast:AssetManager, name:String):Image
		{
			var texture:Texture = ast.getTexture( name );
			if(texture)
				return new Image( texture );
			return null;
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
				_dic[name].dispose();
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