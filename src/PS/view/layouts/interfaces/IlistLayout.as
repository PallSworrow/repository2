package PS.view.layouts.interfaces {
	import flash.display.DisplayObject;
	import PS.model.interfaces.IviewElement;
	//import PS.view.scroller.interfaces.IlistItem;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IlistLayout extends Ilayout
	{
		function addItem(item:IviewElement, forceSize:int=-1):void
		function addItemTo(item:IviewElement,index:int, forceSize:int=-1):void
		function removeItem(item:IviewElement):void
		function removeByIndex(index:int):void
		
		function getListItem(index:int):IlistLayoutItem
		function getItem(index:int):IviewElement
		function getIndexOf(item:IviewElement):int
		
		function get length():int
		
		function get vertical():Boolean
		function set vertical(value:Boolean):void
		
		function get pagesInterval():int
		function set pagesInterval(value:int):void
		
		function get instance():DisplayObject
	}
	
}