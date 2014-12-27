package PS.model.requestSystem.handlers 
{
	import PS.model.requestSystem.IrequestHandler;
	/**
	 * ...
	 * @author 
	 */
	public class VKrequestHandler implements IrequestHandler 
	{
		
		public function VKrequestHandler() 
		{
			
		}
		
		/* INTERFACE PS.model.requestSystem.IrequestHandler */
		
		public function ask(params:Object, positiveAnswer:Function, negativeAnswer:Function):void 
		{
			
		}
		
		public function abort():void 
		{
			
		}
		
		public function forceAnswer(positive:Boolean, answerParams:Object = null):void 
		{
			
		}
		
		public function get isWaiting():Boolean 
		{
			return _isWaiting;
		}
		
	}

}