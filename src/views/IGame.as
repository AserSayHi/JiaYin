package views
{
	/**
	 * 小游戏
	 * @author Administrator
	 */	
	public interface IGame
	{
		function start():void;
		
		function pause():void;
		
		function end():void;
		
		function getResult():void;
	}
	
}