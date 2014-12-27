package PS.view.scroller.interfaces 
{
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface ItableScroller extends IlistScroller
	{
		function scrollToItem(index:int):void
		function get elementsInPage():int
		function set elementsInPage(value:int):void
		function addItemTo2(data:Object,page:int,index:int):void
		
		
		function getNumItems():int
		function getItem(index:int):IviewElement
		function getItem2(page:int, index:int):IviewElement
		
		function set inPageInterval(value:int):void
		function get inPageInterval():int
	}
	
}