package Swarrow.view.glifs 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class GlifEvent extends Event 
	{
		public static const WIDTH_CHANGE:String = 'width_change';
		public static const HEIGHT_CHANGE:String = 'height_change';
		public static const SIZE_CHANGE:String = 'size_change';
		public static const DATA_CHANGF:String = 'data_change';
		public static const STYLE_CHANGE:String = 'style_change';
		public static const MOVE:String = 'move';
		public function GlifEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}