package interfaces
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
		
		function onTimer():void;
		
		function get gameID():String;
	}
}