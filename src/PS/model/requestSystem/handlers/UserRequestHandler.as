package PS.model.requestSystem.handlers 
{
	import PS.model.requestSystem.implementers.UserRequest;
	import PS.model.requestSystem.IrequestInstance;
	import PS.model.requestSystem.RequestHandlerBase;
	import PS.model.requestSystem.RequestImplementer;
	/**
	 * ...
	 * @author 
	 */
	public class UserRequestHandler extends RequestHandlerBase 
	{
		private var popupReq:String;
		public function UserRequestHandler(popupType:String) 
		{
			popupReq = popupType;
		}
		override protected function createRequest():RequestImplementer 
		{
			return new UserRequest(popupReq);
		}
	}

}