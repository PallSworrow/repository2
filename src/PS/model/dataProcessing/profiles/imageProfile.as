package PS.model.dataProcessing.profiles 
{
	/**
	 * ...
	 * @author 
	 */
	public class imageProfile 
	{
		private var _id:String;
		private var _title:String;
		private var _annotation:String;
		private var _source:String;
		private var _big:String;
		private var _thumb:String;
		private var _data:Object;
		
		public function imageProfile(id:String) 
		{
			_id = id;
		}
		
		public function get ID():String 
		{
			return _id;
		}
		
		public function get title():String 
		{
			return _title;
		}
		
		public function get source():String 
		{
			return _source;
		}
		
		public function get big():String 
		{
			return _big;
		}
		
		public function get data():Object 
		{
			return _data;
		}
		
		public function get thumb():String 
		{
			return _thumb;
		}
		
		
		public function get annotation():String 
		{
			return _annotation;
		}
		
		public function set title(value:String):void 
		{
			_title = value;
		}
		
		public function set annotation(value:String):void 
		{
			_annotation = value;
		}
		
		public function set source(value:String):void 
		{
			_source = value;
		}
		
		
		
		public function set big(value:String):void 
		{
			_big = value;
		}
		
		public function set thumb(value:String):void 
		{
			_thumb = value;
		}
		
		public function set data(value:Object):void 
		{
			_data = value;
		}
		
	}

}