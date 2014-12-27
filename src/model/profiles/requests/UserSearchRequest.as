package model.profiles.requests 
{
	import model.profiles.interfaces.IuserSearchRequest;
	/**
	 * ...
	 * @author 
	 */
	public class UserSearchRequest extends SearchRequest implements IuserSearchRequest
	{
		public static function parse(str:String):UserSearchRequest
		{
			var obj:Object = JSON.parse(str);
			var res:UserSearchRequest = new UserSearchRequest();
			
			for each(var st:Object in obj.style) res.style.push(st);
			for each(var gl:Object in obj.goals) res.goals.push(gl);
			//for each(var tr:Object in obj.likedTracks) res.likedTracks.push(tr);
			for each(var tg:Object in obj.instrumentTags) res.instrumentTags.push(tg);
			
			res.readyForLocalTours = obj.readyForLocalTours;
			res.readyForWorldTours = obj.readyForWorldTours;
			res.localTours = obj.localTours;
			res.worldTours = obj.worldTours;
			res.isForFree = obj.isForFree;
			res.needVideo = obj.needVideo;
			res.needAudio = obj.needAudio;
			res.skillLevel = obj.skillLevel;
			
			res.instrumentType = obj.instrumentType;
			
			return res;
			
			
		}
		
		
		private var _instrumentType:String;
		private var _instrumentTagsG:Vector.<String>;
		private var _instrumentTagsY:Vector.<String>;
		private var _instrumentTagsR:Vector.<String>;
		public function UserSearchRequest() 
		{
			super();
			
		}
		
		/* INTERFACE model.profiles.interfaces.IuserSearchRequest */
		
		public function get instrumentTagsG():Vector.<String> 
		{
			return _instrumentTagsG;
		}
		
		public function get instrumentTagsY():Vector.<String> 
		{
			return _instrumentTagsY;
		}
		
		public function get instrumentTagsR():Vector.<String> 
		{
			return _instrumentTagsR;
		}
		
		public function set instrumentTagsG(value:Vector.<String>):void 
		{
			_instrumentTagsG = value;
		}
		
		public function set instrumentTagsY(value:Vector.<String>):void 
		{
			_instrumentTagsY = value;
		}
		
		public function set instrumentTagsR(value:Vector.<String>):void 
		{
			_instrumentTagsR = value;
		}
		
		/* INTERFACE model.profiles.interfaces.IuserSearchRequest */
		
		public function get instrumentType():String 
		{
			return _instrumentType;
		}
		
		public function set instrumentType(value:String):void 
		{
			_instrumentType = value;
		}
		
		
		
	}

}