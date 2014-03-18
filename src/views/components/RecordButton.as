package views.components
{
	import controllers.Assets;
	
	import starling.animation.Juggler;
	import starling.display.Button;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
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
		
		private var assets:AssetManager;
		private var btn:Button;
		private var mc:MovieClip;
		private var juggler:Juggler;
		
		private function init():void
		{
			assets = Assets.instance.getAssetsManager( Assets.Games );
			initBtn();
			initMC();
		}
		
		private function initBtn():void
		{
			btn = new Button( assets.getTexture("") );
			btn.x = btn.pivotX = btn.width >> 1;
			btn.y = btn.pivotY = btn.height >> 1;
			this.addChild( btn );
			btn.x = btn.pivotX;
			btn.addEventListener( Event.TRIGGERED, onTriggered );
		}
		
		private function onTriggered(e:Event):void
		{
			if(recording)
				return;
			recording = true;
			mc.visible = true;
			if(!juggler)
				juggler = new Juggler();
			juggler.add( mc );
			Voice.instance.startRecognizer( onResult );
		}
		
		private function onResult(result:String):void
		{
			recording = false;
			mc.visible = false;
			juggler.remove( mc );
			if(resultHandler)
				resultHandler();
		}
		
		private var resultHandler:Function;
		public function setResultFunction(func:Function):void
		{
			resultHandler = func;
		}
		
		private function initMC():void
		{
			var textures:Vector.<Texture> = assets.getTextures("");
			mc = new MovieClip( textures, 24 );
			mc.pivotX = mc.width >> 1;
			mc.pivotY = mc.height >> 1;
			mc.x = btn.x;
			mc.y = btn.y;
			this.addChild( mc );
			mc.touchable = false;
		}
		
		private var recording:Boolean = false;
		
		override public function dispose():void
		{
			assets = null;
			resultHandler = null;
			if(btn)
			{
				btn.removeEventListener( Event.TRIGGERED, onTriggered );
				btn.removeFromParent( true );
				btn = null;
			}
			if(mc)
			{
				if(juggler)
					juggler.remove( mc );
				juggler = null;
				mc.removeFromParent(true);
				mc = null;
			}
			super.dispose();
		}
	}
}