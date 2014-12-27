package PS.view.gallery.interfaces 
{
	import flash.events.IEventDispatcher;
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface Igallery extends IviewElement
	{
		function addItemData(data:Object, index:int=-1):void
		function removeItemData(index:int):void
		function setData(value:Array):void
		
		function render():void
		function clear():void
		function fullClear():void
		
		function scrollTo(pageIndex:int):void
		
		function next():void
		function prev():void
		function get numPages():int
		function set pageIndex(value:int):void
		function get pageIndex():int
		
		
		function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		
		
	}
	
}