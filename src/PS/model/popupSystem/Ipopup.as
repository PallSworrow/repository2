package PS.model.popupSystem {
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public interface Ipopup extends IEventDispatcher
	{
		function show(parameters:Object=null):void
		function close(parameters:Object=null):void
		
		function setParameter(name:String, value:Object):void
		function getParameter(name:String):Object
		
		function get isShown():Boolean
		
		
		function dispose():void
		
	}
	
}