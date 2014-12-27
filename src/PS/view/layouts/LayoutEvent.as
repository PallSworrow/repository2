package PS.view.layouts 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class LayoutEvent extends Event 
	{
		public static const UPDATE:String = 'update';
		public function LayoutEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}