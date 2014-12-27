package PS.model.requestSystem.handlers 
{
	import PS.model.requestSystem.IrequestHandler;
	
	/**
	 * ...
	 * @author 
	 */
	public class ServerRequesHandler implements IrequestHandler 
	{
		
		public function ServerRequesHandler() 
		{
			
		}
		
		/* INTERFACE PS.model.requestSystem.IrequestHandler */
		
		public function ask(params:Object, positiveAnswer:Function, negativeAnswer:Function):String 
		{
			
		}
		
		public function abort(id:String):void 
		{
			
		}
		
		public function forceAnswer(positive:Boolean, id:String, answerParams:Object = null):void 
		{
			
		}
		
		public function isWaiting(id:String):Boolean 
		{
			
		}
		
		
	}

}