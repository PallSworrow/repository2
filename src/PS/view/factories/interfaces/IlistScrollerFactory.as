package PS.view.factories.interfaces 
{
	import PS.view.scroller.ListScroller;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IlistScrollerFactory 
	{
		function createScroller(w:int,h:int, vertical:Boolean = false):ListScroller
	}
	
}