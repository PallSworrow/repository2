package PS.model.popupSystem.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface IdialoguePopup 
	{
		function ask(positiveHandler:Function, negativeHandler:Function,question:Object = null):void
		function forceAnswer(positive:Boolean, params:Object = null):void
		function setParameter(name:String, value:Object):void
		function getParameter(name:String):Object
		
		function get isShown():Boolean
		
		
	}
	
}