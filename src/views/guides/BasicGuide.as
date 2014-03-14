package views.guides
{
	import controllers.Assets;
	
	import events.GuideEvent;
	
	import models.PosVO;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	import utils.StatusManager;

	public class BasicGuide extends Sprite
	{
		public function BasicGuide()
		{
			super();
		}
		
		protected var assets:AssetManager;
		protected var mStatus:StatusManager;
		final public function initialize():void
		{
			mStatus = StatusManager.getInstance();
			assets = Assets.instance.getAssetsManager( Assets.Games );
			initHandler();			//指引初始化
			this.addEventListener( GuideEvent.CHANGED, onStepChanged );
			dispatchEvent( new GuideEvent(GuideEvent.INITIALIZED) );
		}
		
		/*↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓拓展类重写以下该方法↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓*/
		protected function initHandler():void
		{
		}
		protected function startGuide():void
		{
		}
		protected function onStepChanged(e:GuideEvent):void
		{
		}
		/*↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑拓展类重写以上该方法↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑*/
		
		final protected function setBG(t:Texture):void
		{
			var image:Image = new Image(t);
			this.addChild( image );
			image.x = PosVO.REAL_WIDTH - PosVO.LOGIC_WIDTH >> 1;
			image.y = PosVO.REAL_HEIGHT - PosVO.LOGIC_HEIGHT >> 1;
			trace(image.x, image.y);
		}
		
		final public function play():void
		{
			_state = 0;
			startGuide();
		}
		private var _state:int = -1;
		final protected function next():void
		{
			_state += 1;
			dispatchEvent( new GuideEvent( GuideEvent.CHANGED, _state ) );
		}
		
		final protected function end():void
		{
			dispatchEvent( new GuideEvent( GuideEvent.ENDED ));
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
	}
}