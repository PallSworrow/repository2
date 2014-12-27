package Swarrow.models 
{
	import flash.display.Stage;
	/**
	 * ...
	 * @author 
	 */
	public class Globals 
	{
		internal static var _width:int;
		internal static var _height:int;
		internal static var _stage:Stage;
		
		static public function get width():int 
		{
			return _width;
		}
		
		static public function get height():int 
		{
			return _height;
		}
		
		static public function get stage():Stage 
		{
			return _stage;
		}
	}

}