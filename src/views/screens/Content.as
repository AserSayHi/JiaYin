package views.screens
{
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
	}
}