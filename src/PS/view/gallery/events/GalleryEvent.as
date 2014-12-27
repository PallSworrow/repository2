package PS.view.gallery.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class GalleryEvent extends Event 
	{
		public static const EMPTY_TAP:String = 'galleryTap';
		public static const ITEM_TAP:String = 'itemTap';
		public static const ARROW_TAP:String = 'arrowTap';
		public function GalleryEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}