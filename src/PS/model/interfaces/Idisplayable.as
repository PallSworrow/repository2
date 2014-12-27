package PS.model.interfaces {
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author 
	 */
	public interface Idisplayable 
	{
		function addTo(container:DisplayObjectContainer):void
		function remove():void
		function dispose():void
	}
	
}