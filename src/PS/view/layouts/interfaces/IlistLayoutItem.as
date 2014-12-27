package PS.view.layouts.interfaces {
	import flash.display.DisplayObject;
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IlistLayoutItem
	{
		function get item():IviewElement
		function get offset():int
		function set offset(value:int):void
		function get size():int
		function set size(value:int):void
		
		function set vertical(value:Boolean):void
		function get vertical():Boolean
		
	}
	
}