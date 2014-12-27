package PS.model.apiInteraction 
{
	import PS.model.requestSystem.implementers.ServerRequest;
	
	/**
	 * ...
	 * @author 
	 */
	public class ApiRequest extends ServerRequest 
	{
		
		
		private var method:String;
		private var decoder:IapiMethodDecoder;
		public function ApiRequest(domain:String,apiMethod:String, methodDecoder:IapiMethodDecoder=null) 
		{
			method = apiMethod;
			decoder = methodDecoder;
			super(domain+method);
			
		}
		override protected function call(params:Object):void 
		{
			
			if (decoder) 
			{
				super.call(decoder.checkCallParams(params,method));
			}
			else super.call(params);
		}
		override protected function abort():void 
		{
			super.abort();
		}
		override protected function loadComplete(params:Object):void 
		{
			if (decoder)
			{
				var result:ApiMethodResult = decoder.checkLoadResult(params,method);
				solve(result.positive, result.data);
			}
			else super.call(params);
			
		}
		override protected function loadFailed(params:Object):void 
		{
			if (decoder)
			{
				super.loadFailed(decoder.onError(params,method));
			}
			else super.loadFailed(params);
		}
		
		
	}

}