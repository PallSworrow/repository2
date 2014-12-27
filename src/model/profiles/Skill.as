package model.profiles 
{
	import model.constants.SkillLevel;
	import model.profiles.interfaces.IskillProfile;
	/**
	 * ...
	 * @author 
	 */
	public class Skill implements IskillProfile
	{
		public static function parse(item:Object):Skill
		{
			
			var res:Skill = new Skill(item.type);
			/*var arr:Array = str.split('&');
			var item:Object={};
			for each(var prop:Object in arr)
			{
				prop = prop.split('=');
				item[prop[0]] = prop[1];
			}
			res.level = item.level;
			res.tags = Vector.<String>(item.tags.split('+'));
			res.audio = Vector.<String>(item.audio.split('+'));
			res.video = Vector.<String>(item.video.split('+'));*/
			
			for each(var prop:Object in item.tags)
			{
				res.tags.push(String(prop));
			}
			for each(var track:Object in item.audio)
			{
				res._audio.push(String(track));
			}
			for each(var link:Object in item.video)
			{
				res.video.push(String(link));
			}
			res.level = item.level;
			return res;
			
		}
		/*public function toString():String
		{
			var res:String;
			var arr:Array = [];
			arr.push( { name:'"type"',  value:'"'+type+'"' } );
			arr.push( { name:'"level"', value:'"'+level+'"' } );
			arr.push( { name:'"tags"',  value:'"'+tags.join('","') +'"' } );
			arr.push( { name:'"audio"', value:'"'+audio.join('","')+'"' } );
			arr.push( { name:'"video"', value:'"'+video.join('","')+'"' } );
			for each(var param:Object in arr) 
			param = param.name+'=' + String(param.value);
			res = arr.join('&');
			return res;
		}*/
		private var _type:String;
		private var _tags:Vector.<String> = new Vector.<String>;
		private var _level:int=0;
		private var _audio:Vector.<String> = new Vector.<String>;
		private var _video:Vector.<String> = new Vector.<String>;
		
		public function Skill(type:String) 
		{
			_type = type;
		}
		
		/* INTERFACE model.profiles.interfaces.IskillProfile */
		
		public function set audio(value:Vector.<String>):void 
		{
			_audio = value;
		}
		
		public function get audio():Vector.<String> 
		{
			return _audio;
		}
		
		public function set video(value:Vector.<String>):void 
		{
			_video = value;
		}
		
		public function get video():Vector.<String> 
		{
			return _video;
		}
		
		/* INTERFACE model.profiles.interfaces.IskillProfile */
		
		public function get type():String 
		{
			return _type;
		}
		
		public function get tags():Vector.<String> 
		{
			return _tags;
		}
		
		public function get level():int 
		{
			return _level;
		}
		
		public function set level(value:int):void 
		{
			_level = value;
		}
		
	}

}