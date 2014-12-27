package PS.model.requestSystem.handlers 
{
	import PS.constants.OrderType;
	import PS.model.requestSystem.implementers.ImgLoader;
	import PS.model.requestSystem.RequestHandlerBase;
	import PS.model.requestSystem.RequestImplementer;
	
	/**
	 * ...
	 * @author 
	 */
	public class GetImageHandler extends RequestHandlerBase 
	{
		
		public function GetImageHandler() 
		{
			super();
			setOrderType(OrderType.PARALLEL);
		}
		override protected function createRequest():RequestImplementer 
		{
			return new ImgLoader();
		}
	}

}