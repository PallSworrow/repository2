package PS.model.requestSystem.apiInteraction 
{
	import PS.model.requestSystem.implementers.ServerRequest;
	
	/**
	 * ...
	 * @author 
	 */
	public class ApiRequest extends ServerRequest 
	{
		
		
		private var apiMethod:String;
		private var decoder:IapiMethodDecoder;
		public function ApiRequest(domain:String,apiMethod:String, methodDecoder:IapiMethodDecoder=null) 
		{
			method = method;
			decoder = methodDecoder;
			super(domain+method);
			
		}
		override protected function call(params:Object):void 
		{
			if (decoder) super.call(decoder.checkCallParams(params,apiMethod));
			else super.call(params);
		}
		override protected function loadComplete(params:Object):void 
		{
			if (decoder)
			{
				var result:ApiMethodResult = decoder.checkLoadResult(params,apiMethod);
				solve(result.positive, result.data);
			}
			else super.call(params);
			
		}
		override protected function loadFailed(params:Object):void 
		{
			if (decoder)
			{
				super.loadFailed(decoder.onError(params,apiMethod));
			}
			else super.loadFailed(params);
		}
		
		
	}

}