package PS.model.requestSystem.handlers 
{
	import PS.model.requestSystem.implementers.ServerRequest;
	import PS.model.requestSystem.RequestHandlerBase;
	import PS.model.requestSystem.RequestImplementer;
	
	/**
	 * ...
	 * @author 
	 */
	public class URLloaderHandler extends RequestHandlerBase 
	{
		private var url:String
		public function URLloaderHandler(domain:String=null) 
		{
			super();
			url = domain;
		}
		override protected function createRequest():RequestImplementer 
		{
			return new ServerRequest(url);
		}
		
	}

}