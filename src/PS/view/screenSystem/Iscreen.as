package PS.view.screenSystem 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface Iscreen 
	{
		function show():void
		function hide():void
		
		function load(data:Object):void
		function clear():void
		
		function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
	}
	
}