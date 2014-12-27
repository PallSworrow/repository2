package PS.view.scroller.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class ListEvent extends Event 
	{
		public static const PAGE_SHOWN:String = 'pageshown';
		public static const LAST_PAGE:String = 'lastPage';
		public static const FIRST_PAGE:String = 'firstPage';
		
		
		private var index:int;
		public function ListEvent(type:String, pageIndex:int) 
		{
			index = pageIndex;
			super(type, bubbles, cancelable);
			
		}
		public function get pageIndex():int
		{
			return index;
		}
		
	}

}