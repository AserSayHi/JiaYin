package models
{
	public class GameResultVO
	{
		public function GameResultVO(startNum:int)
		{
			this._starNum =startNum;
		}
		
		private var _starNum:int;
		/**
		 * 星星数量
		 */		
		public function get starNum():int
		{
			return _starNum;
		}
	}
}