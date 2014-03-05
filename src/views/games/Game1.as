package views.games
{
	public class Game1 extends BasicGame
	{
		public function Game1()
		{
			super();
		}
		
		//override functions=============================================================
		override public function initialize(teach:Boolean=false):void
		{
			initBG( assets.getTexture( "mainBG" ));
			//初始化游戏内容
			//。。。
			dispatchEventWith( INITIALIZED );
		}
		override public function start():void
		{
		}
		override public function restart():void
		{
		}
		override public function pauseGame():void
		{
		}
		override public function continueGame():void
		{
		}
		override public function end():void
		{
		}
		override public function dispose():void
		{
		}
	}
}