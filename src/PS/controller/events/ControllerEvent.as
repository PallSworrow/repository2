package PS.controller.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class ControllerEvent extends Event 
	{
		public static const ON_TAP:String = 'tap';
		public static const ON_PRESS:String = 'press';
		public static const ON_RELEASE:String = 'release';
		public static const ON_MOVE:String = 'move';
		public static const NO_GESS_RECONGIZED:String = 'allfailed';
		
		public function ControllerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}