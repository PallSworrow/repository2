package PS.view.scroller.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScrollerEvent extends Event 
	{
		public static const SCROLL:String = 'scroll';
		public static const SCROLL_COMPLETE:String = 'scrollcomplete';
		public static const MAX_OFFSET:String = 'maxoffset';
		public static const MIN_OFFSET:String = 'minoffset';
		public static const UPDATE:String = 'update';
		public function ScrollerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}