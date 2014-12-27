package PS.controller.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class SwipeEvent extends Event 
	{
		public static const SWIPE:String = 'swipe';
		public static const LEFT:String = 'left';
		public static const RIGHT:String = 'right';
		public static const UP:String = 'up';
		public static const DOWN:String = 'down';
		public static const FAILED:String = 'swipefail';
		
		
		private var _direction:String;
		public function SwipeEvent(type:String, dir:String=null) 
		{
			super(type, bubbles, cancelable);
			if (type == SWIPE) _direction = dir;
			else _direction = type;
		}
		
		public function get direction():String 
		{
			return _direction;
		}
		
	}

}