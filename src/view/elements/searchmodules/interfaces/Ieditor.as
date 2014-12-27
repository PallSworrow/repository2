package view.elements.searchmodules.interfaces 
{
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface Ieditor extends IviewElement
	{
		function get title():String
		function set title(value:String):void
		
		function get propName():String
		function set propName(value:String):void
		//function addEventListener (type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false) : void;
		//function removeEventListener (type:String, listener:Function, useCapture:Boolean=false) : void;
		function set valueFilter(value:Function):void 
		function get isNecessery():Boolean
		function set isNecessery(value:Boolean):void 
		function get isEmpty():Boolean
		function setUpdateHandler(value:Function,params:Object):void
	}
	
}