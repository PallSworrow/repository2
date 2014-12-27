package model.instagramApi.handlers 
{
	import model.instagramApi.constants.ApiMethod;
	import model.instagramApi.ApiDecoder;
	import model.instagramApi.Instagram;
	import PS.constants.OrderType;
	import PS.model.apiInteraction.ApiRequest;
	import PS.model.apiInteraction.IapiMethodDecoder;
	import PS.model.requestSystem.RequestHandlerBase;
	import PS.model.requestSystem.RequestImplementer;
	
	/**
	 * ...
	 * @author 
	 */
	public class InstagramRequestHandler extends RequestHandlerBase 
	{
		private static const decoder:IapiMethodDecoder = new ApiDecoder();
		private var method:String;
		public function InstagramRequestHandler(reqType:String) 
		{
			super();
			method = reqType
			setOrderType(OrderType.PARALLEL);
		}
		override protected function createRequest():RequestImplementer 
		{
			return new ApiRequest(Instagram.DOMAIN, method, decoder);
		}
	}

}