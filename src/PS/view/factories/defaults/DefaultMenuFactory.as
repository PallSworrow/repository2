package PS.view.factories.defaults 
{
	import PS.view.buttonMenus.IbuttonMenu;
	import PS.view.buttonMenus.implementations.BtnListMenu;
	import PS.view.factories.interfaces.ImenuFactory;
	
	/**
	 * ...
	 * @author 
	 */
	public class DefaultMenuFactory implements ImenuFactory 
	{
		
		public function DefaultMenuFactory() 
		{
			
		}
		
		/* INTERFACE PS.view.factories.interfaces.ImenuFactory */
		
		public function createList(names:Vector.<String>):IbuttonMenu 
		{
			return new BtnListMenu(names);
		}
		
	}

}