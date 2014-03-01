package controllers
{
	import com.pamakids.utils.Singleton;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	
	import models.PosVO;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	import views.ScreenContainer;
	import views.components.MainLoading;
	import views.components.Stage2D;
	import views.components.Stage3D;
	
	public class MC extends Singleton
	{
		public static const LOGIC_WIDTH:uint = 1280;
		public static const LOGIC_HEIGHT:uint = 960;
		public static const CENTER:Point = new Point( LOGIC_WIDTH/2, LOGIC_HEIGHT/2 );
		
		public static function get instance():MC
		{
			return Singleton.getInstance( MC );
		}
		
		//原生flash显示对象容器
		private var stage2d:Stage2D;
		//starling显示对象容器
		private var stage3d:Stage3D;
		
		private var main3d:starling.display.Sprite;
		private var main2d:flash.display.Sprite
		
		private var mainLoading:MainLoading;
		
		public function initialize(main:starling.display.Sprite):void
		{
			//starling显示层初始化
			this.main3d = main;
			main3d.scaleX = main3d.scaleY = PosVO.scale;
			main3d.x = PosVO.OffsetX * PosVO.scale;
			main3d.y = PosVO.OffsetY * PosVO.scale;
			stage3d = new Stage3D(main3d);
			
			//原生显示层容器初始化
			main2d = new flash.display.Sprite();
			main2d.scaleX = main2d.scaleY = PosVO.scale;
			main2d.x = PosVO.OffsetX;
			main2d.y = PosVO.OffsetY;
			Starling.current.nativeStage.addChild( main2d );
			stage2d = new Stage2D(main2d);
			
			//mainUI资源加载
			loadAssets();
		}
		
		private var assets:AssetManager;
		private function loadAssets():void
		{
			mainLoading = new MainLoading();
			addToStage2D( mainLoading, true );
			
			assets = Assets.instance.getAssetsManager( Assets.MAIN_UI );
			assets.enqueue(File.applicationDirectory.resolvePath("assets/mainUI"));
			assets.loadQueue( function(ratio:Number):void{
				if(ratio == 1)
				{
					initScreenContainer();
					delChild( mainLoading );
				}
			} );
		}
		
		private var screenContainer:ScreenContainer;
		private function initScreenContainer():void
		{
			screenContainer = new ScreenContainer();
			stage3d.addChild( screenContainer );
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
	}
}