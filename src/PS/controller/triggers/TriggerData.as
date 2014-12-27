package PS.controller.triggers 
{
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author 
	 */
	public class TriggerData implements ItriggerData
	{
		private var _id:String;
		private var _params:Object;
		private var _rectangle:Rectangle;
		
		private var handler:Function;
		public function TriggerData(Handler:Function = null) 
		{
			handler = Handler;
		}
		public function callHandler():void
		{
			if (handler is Function)
			{
				if (data != null) handler(data);
				else handler();
			}
		}
		/* INTERFACE PS.controller.triggers.ItriggerData */
		
		public function get id():String 
		{
			return _id;
		}
		
		public function get data():Object 
		{
			return _params;
		}
		
		public function get rectangle():Rectangle 
		{
			return _rectangle;
		}
		//SETTERS:
		public function set rectangle(value:Rectangle):void 
		{
			_rectangle = value;
		}
		
		public function set data(value:Object):void 
		{
			_params = value;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
	}

}