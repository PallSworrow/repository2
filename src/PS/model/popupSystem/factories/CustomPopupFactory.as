package PS.model.popupSystem.factories 
{
	import PS.model.popupSystem.Ipopup;
	import PS.model.popupSystem.IpopupFactory;
	
	/**
	 * ...
	 * @author 
	 */
	public class CustomPopupFactory implements IpopupFactory 
	{
		private var provider:Function
		public function CustomPopupFactory(instProvider:Function) 
		{
			provider = instProvider;
		}
		
		/* INTERFACE PS.model.popupSystem.IpopupFactory */
		
		public function createPopup():Ipopup 
		{
			return provider();
		}
		
	}

}