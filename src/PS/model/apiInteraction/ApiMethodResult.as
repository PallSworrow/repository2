package PS.model.apiInteraction 
{
	/**
	 * ...
	 * @author 
	 */
	public class ApiMethodResult 
	{
		private var _positive:Boolean;
		private var _data:Object;
		public function ApiMethodResult(positive:Boolean,data:Object) 
		{
			_positive = positive;
			_data = data;
		}
		
		public function get data():Object 
		{
			return _data;
		}
		
		public function get positive():Boolean 
		{
			return _positive;
		}
	}

}