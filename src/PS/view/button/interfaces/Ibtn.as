package PS.view.button.interfaces {
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface Ibtn extends IviewElement
	{
		function tap(callHandler:Boolean = true):void
		
		function set group(value:String):void
		function get group():String
		
		function setHandler(func:Function,params:Object=null):void
		function get isHandlerSet():Boolean
		
		function setPhaze(value:String):void
		function get phaze():String
		
		
		//function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		//function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		
		
	}
	
}