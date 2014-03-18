package views.screens
{
	import models.PosVO;
	
	import views.components.UI_contentScreen;
	import views.units.BasicUnit;

	/**
	 * 教学主场景，每个主场景内容不同，需要加载不同的教学单元
	 * @author kc2ong
	 */	
	public class Content extends BasicScreen
	{
		
		/**
		 * 内容单元
		 */		
		private var unit:BasicUnit;
		
		public function Content()
		{
			super();
		}
		
		override protected function initHandler():void
		{
			initUI();
			initCompleted();
		}
		
		private var UI:UI_contentScreen;
		private function initUI():void
		{
			UI = new UI_contentScreen();
			this.addChild( UI );
			UI.pivotX = UI.width >> 1;
			UI.x = PosVO.REAL_WIDTH >> 1;
			UI.y = 0;
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
	}
}