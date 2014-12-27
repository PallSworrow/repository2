package PS.model 
{
	import flash.display.Stage;
	/**
	 * ...
	 * @author 
	 */
	public class Globals 
	{
		private static var _width:int;
		private static var _height:int;
		internal static function init(w:int, h:int):void
		{
			_width = w;
			_height = h;
		}
		
		public static function get Width():int
		{
			return _width;
		}
		public static function get Height():int
		{
			return _height;
		}
		
		
		
	}

}