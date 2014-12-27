package PS.model.requestSystem 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface IrequestInstance 
	{
		/**
		 * Функция должна принимать this в качестве параметра
		 * и вызываeтся после полнового завершения процедуры.
		 * Назначается только после init();
		 */
		function get id():String;
		function get currentPhaze():String 
		function set onCompleteHandler(value:Function):void
		function init():void
		function forceAnswer(positive:Boolean, params:Object):void
		function abort():void
		
		/**
		 * final distruction - no events after it.
		 * clear memory & link
		 */
		function dispose():void
		/**
		 * unsupported for now
		 */
		function pause():void
	}
	
}