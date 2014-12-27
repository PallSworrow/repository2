package PS.view.valueInput.numbeTyped 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class NumberInputEvent extends Event 
	{
		public static const UPPER_LIMIT:String = 'upperLimit';
		public static const LOWER_LIMIT:String = 'lowerLimit';
		public static const UPPER_LIMIT_EXCEEDED:String = 'upperLimit_exceeded';
		public static const LOWER_LIMIT_EXCEEDED:String = 'lowerLimit_exceeded';
		public static const VALUE_CHANGED:String = 'valueChanged';
		
		public function NumberInputEvent(type:String) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}