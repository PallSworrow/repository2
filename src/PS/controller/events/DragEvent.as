package PS.controller.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class DragEvent extends Event 
	{
		public static const ON_GRAB:String = 'grab';
		public static const ON_DRAG:String = 'drag';
		public static const INNERTION:String = 'innertion';
		public static const ON_MOVE_COMPLETE:String = 'complete';
		
		public static const ON_DROP:String = 'drop';
		public function DragEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}