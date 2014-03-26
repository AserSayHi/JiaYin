package controllers
{
	import com.pamakids.utils.Singleton;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import models.PosVO;
	import models.code.ScreenCode;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	import utils.GameController;
	import utils.ScreenController;
	import utils.StatusManager;
	
	import views.components.MainLoading;
	import views.components.Stage2D;
	import views.components.Stage3D;
	
	public class MC extends Singleton
	{
		public static function get instance():MC
		{
			return Singleton.getInstance( MC );
		}
		
		private var stage2d:Stage2D;		//原生flash显示对象容器
		private var stage3d:Stage3D;		//starling显示对象容器
		private var main2d:flash.display.Sprite;	//stage2d父级容器
		private var main3d:starling.display.Sprite;	//stage3d父级容器
		
		private var sController:ScreenController;	//场景控制器	
		private var gController:GameController;		//游戏控制器
		
		public function initialize(main:starling.display.Sprite):void
		{
			//初始化页面控制器
			sController = ScreenController.instance();
			gController = GameController.instance();
			
			//starling显示层初始化
			this.main3d = main;
			main3d.scaleX = main3d.scaleY = PosVO.scale;
			stage3d = new Stage3D(main3d);
			
			//原生显示层初始化
			main2d = new flash.display.Sprite();
			main2d.scaleX = main2d.scaleY = PosVO.scale;
			main2d.x = PosVO.OffsetX;
			main2d.y = PosVO.OffsetY;
			Starling.current.nativeStage.addChild( main2d );
			main2d.mouseEnabled = false;
			stage2d = new Stage2D(main2d);
			
			sController.openScreen( ScreenCode.MAP );
		}
	
		private var loading:MainLoading;
		public function showLoading():void
		{
			if(loading)
				return;
			loading = new MainLoading();
			this.addToStage2D( loading, true );
		}
		public function hideLoading(callBack:Function=null):void
		{
			if(!loading)
				return;
			StatusManager.getInstance().addFunc( 
				function():void{
					loading.alpha -= .1;
				}, 50, 10, 
				function():void{
					loading.parent.removeChild( loading );
					loading = null;
					if(callBack)
						callBack();
				}
			);
		}
		
		/**
		 * @param child 
		 * @param local 指定对象当前坐标为局部坐标，若值为flase，则对象默认是以设备左上角为原点
		 */		
		public function addToStage2D(child:flash.display.DisplayObject, local:Boolean=false):void
		{
			stage2d.addChild( child, local );
		}
		
		public function addToStage3D(child:starling.display.DisplayObject, local:Boolean=false):void
		{
			stage3d.addChild( child, local );
		}
		
		public function delChild(child:Object):void
		{
			if(child is flash.display.DisplayObject || child is starling.display.DisplayObject)
			{
				if(child.parent)
					child.parent.removeChild( child );
			}
		}
		
		public function getGameController():GameController
		{
			return gController;
		}
		
		public function getScreenController():ScreenController
		{
			return sController;
		}
		
	}
}