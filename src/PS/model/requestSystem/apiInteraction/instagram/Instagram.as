package model.instagramApi 
{
	import flash.events.EventDispatcher;
	import PS.constants.VarName;
	import PS.model.requestSystem.constants.RequestType;
	import PS.model.requestSystem.RequestManager;
	/**
	 * ...
	 * @author 
	 */
	public class Instagram 
	{
		
		public static const DOMAIN:String = 'https://api.instagram.com/v1';
		private static var _clientId:String;
		static public function get ClientID():String 
		{
			return _clientId;
		}
		
	
		private static var completeHandler:Function;
		public static function init(id:String):void
		{
			_clientId = id;
			
		}
		
		
		
		
	}

}