package PS.view.factories.defaults 
{
	import PS.view.factories.interfaces.IlistLayoutFactory;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.layouts.interfaces.IlistLayout;
	
	/**
	 * ...
	 * @author 
	 */
	public class DefaultListLayoutFactory implements IlistLayoutFactory 
	{
		
		public function DefaultListLayoutFactory() 
		{
			
		}
		
		/* INTERFACE PS.view.factories.interfaces.IlistLayoutFactory */
		
		public function createLayout():IlistLayout 
		{
			return new SimpleListLayout();
		}
		
	}

}