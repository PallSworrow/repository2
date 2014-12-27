package model.profiles.requests {
	import model.profiles.interfaces.IsearchRequest;
	/**
	 * ...
	 * @author 
	 */
	public class SearchRequest implements IsearchRequest
	{
		private var _city:Array;
		private var _styleG:Vector.<String>;
		private var _styleG:Vector.<String>;
		private var _styleY:Vector.<String>;
		private var _styleR:Vector.<String>;
		private var _needAudio:Boolean;
		private var _needVideo:Boolean;
		private var _localTours:Boolean;
		private var _worldTours:Boolean;
		private var _readyForLocalTours:Boolean;
		private var _readyForWorldTours:Boolean;
		private var _goalsG:Vector.<String>;
		private var _goalsY:Vector.<String>;
		private var _goalsR:Vector.<String>;
		private var _skillLevel:Array;
		private var _isForFree:Boolean;
		
		public static function stringify(req:IsearchRequest):String
		{
			return JSON.stringify(req);
		}
		
	
		public function SearchRequest() 
		{
		}
		
		/* INTERFACE model.profiles.interfaces.IsearchRequest */
		
		public function get city():Array 
		{
			return _city;
		}
		
		public function get styleG():Vector.<String> 
		{
			return _styleG;
		}
		
		public function get styleY():Vector.<String> 
		{
			return _styleY;
		}
		
		public function get styleR():Vector.<String> 
		{
			return _styleR;
		}
		
		public function get needAudio():Boolean 
		{
			return _needAudio;
		}
		
		public function get needVideo():Boolean 
		{
			return _needVideo;
		}
		
		public function get localTours():Boolean 
		{
			return _localTours;
		}
		
		public function get worldTours():Boolean 
		{
			return _worldTours;
		}
		
		public function get readyForLocalTours():Boolean 
		{
			return _readyForLocalTours;
		}
		
		public function get readyForWorldTours():Boolean 
		{
			return _readyForWorldTours;
		}
		
		public function get goalsG():Vector.<String> 
		{
			return _goalsG;
		}
		
		public function get goalsY():Vector.<String> 
		{
			return _goalsY;
		}
		
		public function get goalsR():Vector.<String> 
		{
			return _goalsR;
		}
		
		public function get skillLevel():Array 
		{
			return _skillLevel;
		}
		
		public function get isForFree():Boolean 
		{
			return _isForFree;
		}
		
		public function set city(value:Array):void 
		{
			_city = value;
		}
		
		public function set styleG(value:Vector.<String>):void 
		{
			_styleG = value;
		}
		
		public function set styleY(value:Vector.<String>):void 
		{
			_styleY = value;
		}
		
		public function set styleR(value:Vector.<String>):void 
		{
			_styleR = value;
		}
		
		public function set needAudio(value:Boolean):void 
		{
			_needAudio = value;
		}
		
		public function set needVideo(value:Boolean):void 
		{
			_needVideo = value;
		}
		
		public function set localTours(value:Boolean):void 
		{
			_localTours = value;
		}
		
		public function set worldTours(value:Boolean):void 
		{
			_worldTours = value;
		}
		
		public function set readyForLocalTours(value:Boolean):void 
		{
			_readyForLocalTours = value;
		}
		
		public function set readyForWorldTours(value:Boolean):void 
		{
			_readyForWorldTours = value;
		}
		
		public function set goalsG(value:Vector.<String>):void 
		{
			_goalsG = value;
		}
		
		public function set goalsY(value:Vector.<String>):void 
		{
			_goalsY = value;
		}
		
		public function set goalsR(value:Vector.<String>):void 
		{
			_goalsR = value;
		}
		
		public function set skillLevel(value:Array):void 
		{
			_skillLevel = value;
		}
		
		public function set isForFree(value:Boolean):void 
		{
			_isForFree = value;
		}
		
		
		
		
		
	}

}