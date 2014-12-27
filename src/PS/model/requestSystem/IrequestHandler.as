package PS.model.requestSystem {
	
	/**
	 * ...
	 * @author 
	 */
	public interface IrequestHandler 
	{
		function ask(params:Object, positiveAnswer:Function, negativeAnswer:Function):String
		function abort(id:String):void
		function forceAnswer(positive:Boolean,id:String, answerParams:Object = null):void
		function getPhaze(id:String):String
		function dispose():void
		
	}
	
}