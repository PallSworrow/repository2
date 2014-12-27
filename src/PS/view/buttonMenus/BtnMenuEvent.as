package PS.view.buttonMenus 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class BtnMenuEvent extends Event 
	{
		public static const BTN_TAP:String = 'btntap';
		public static const BTN_SELECT:String = 'btnselect';
		public static const BTN_UNSELECT:String = 'btnunselect';
		public static const UPDATE:String = 'update';
		
		public static const NEW_BTN:String = 'newbtn';
		
		
		private var _btnName:String
		public function BtnMenuEvent(type:String, btnName:String=null ) 
		{
			super(type);
			_btnName = btnName;
		}
		
		public function get btnName():String 
		{
			return _btnName;
		}
		
	}

}