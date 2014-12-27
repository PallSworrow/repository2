package PS.model.dataProcessing.profiles 
{
	import com.greensock.loading.core.DisplayObjectLoader;
	/**
	 * ...
	 * @author 
	 */
	public class UserProfile
	{
		private var _ID:String;
		private var _firstName:String;
		private var _lastName:String;
		private var _nickName:String;
		private var _photoURL:String;
		private var _data:Object;
		
		public function UserProfile(id:String) 
		{
			_ID = id;
		}
		private var _loaded:Boolean;
		public function update(f_name:String, s_name:String,photo:String=null, nick:String=null,  data:Object=null):void
		{
			_loaded = true;
			_firstName = f_name;
			_lastName = s_name;
			_nickName = nick;
			_photoURL = photo;
			_data = data;
		}
		public function get ID():String 
		{
			return _ID;
		}
		
		public function get firstName():String 
		{
			return _firstName;
		}
		
		public function get lastName():String 
		{
			return _lastName;
		}
		
		public function get nickName():String 
		{
			return _nickName;
		}
		
		public function get photoURL():String 
		{
			return _photoURL;
		}
		
		public function get data():Object 
		{
			return _data;
		}
		
		public function get loaded():Boolean 
		{
			return _loaded;
		}
		
		
	}

}