package PS.model.interfaces 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public interface AddRemoveEventListener
	{
		function addEventListener (type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false) : void;
		function removeEventListener (type:String, listener:Function, useCapture:Boolean=false) : void;

	}
	
}