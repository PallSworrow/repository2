package PS.model.requestSystem.handlers 
{
	import PS.model.requestSystem.implementers.RandomAnswer;
	import PS.model.requestSystem.RequestHandlerBase;
	import PS.model.requestSystem.RequestImplementer;
	
	/**
	 * ...
	 * @author 
	 */
	public class TestReqHandler extends RequestHandlerBase 
	{
		
		public function TestReqHandler() 
		{
			super();
			
		}
		override protected function createRequest():RequestImplementer 
		{
			
			return new RandomAnswer();
		}
	}

}