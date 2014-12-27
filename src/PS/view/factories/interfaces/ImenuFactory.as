package PS.view.factories.interfaces {
	import PS.view.buttonMenus.IbuttonMenu;
	
	/**
	 * ...
	 * @author 
	 */
	public interface ImenuFactory 
	{
		function createList(names:Vector.<String>):IbuttonMenu
	}
	
}