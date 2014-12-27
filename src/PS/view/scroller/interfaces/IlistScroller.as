package PS.view.scroller.interfaces 
{
	import PS.model.interfaces.IviewElement;
	import PS.view.layouts.interfaces.IlistLayoutItem;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IlistScroller extends Iscroller
	{
		//methods:
	
		function scrollToPage(pageIndex:int):void
		function snap():void
		
		function get currentPage():int 
		function set currentPage(value:int):void 
		
		//
		function addItemTo(data:Object, index:int):void
		function removeItem(index:int):void
		
		
		//getters:
		function getNumpages():int
		//function getCurrentPage():int
		function getPage(index:int):Ipage
		
		
	
		//flags:
		function get snapToPages():Boolean
		function set snapToPages(value:Boolean):void
		
		function get updatePageIndexbeforeSwipe():Boolean 
		function set updatePageIndexbeforeSwipe(value:Boolean):void 
		
		function get renderControll():Boolean 
		function set renderControll(value:Boolean):void 
		
		function get autoFreeSpace():Boolean 
		function set autoFreeSpace(value:Boolean):void 
	
		//customisation:
		function set pagesBySwipe(value:int):void
		function get pagesBySwipe():int
		function set snapDuration(value:Number):void
		function get snapDuration():Number
		
		function get renderZone():int 
		function set renderZone(value:int):void 
		
		function get preloadZone():int 
		function set preloadZone(value:int):void 
		
		
		function set pagesInterval(value:int):void
		function get pagesInterval():int
		
		function set itemProvider(value:Function):void
		
	}
	
}