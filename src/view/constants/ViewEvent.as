package view.constants 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class ViewEvent extends Event 
	{
		public static const UPDATE:String = 'update';
		public function ViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}