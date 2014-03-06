package views.games
{
	public class Game1 extends BasicGame
	{
		public function Game1()
		{
			super();
		}
		
		//override functions=============================================================
		override protected function initGameContent():void
		{
			setGameBG( assets.getTexture( "mainBG" ));
		}
	}
}