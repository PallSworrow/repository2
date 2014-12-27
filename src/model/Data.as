package model 
{
	import adobe.utils.ProductManager;
	import model.profiles.MusicianProfile;
	/**
	 * ...
	 * @author 
	 */
	public class Data 
	{
		internal static var _viewerId:String;
		internal static var _viewerProfile:MusicianProfile;
		
		static public function get viewerId():String 
		{
			return _viewerId;
		}
		
		static public function get viewerProfile():MusicianProfile 
		{
			return _viewerProfile;
		}
		
	}

}