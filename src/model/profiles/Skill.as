package model.profiles 
{
	import model.constants.SkillLevel;
	import model.profiles.interfaces.IskillProfile;
	import Swarrow.tools.dataObservers.ArrayObserver;
	import Swarrow.tools.dataObservers.DataObserver;
	import Swarrow.tools.dataObservers.IntegerObserver;
	/**
	 * ...
	 * @author 
	 */
	public class Skill extends DataObserver
	{
		public function parse(item:Object):void
		{
			type = item.type;
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
				tags.push(String(prop));
			}
			for each(var track:Object in item.audio)
			{
				audio.push(String(track));
			}
			for each(var link:Object in item.video)
			{
				video.push(String(link));
			}
			level.currentValue = item.level;
			
		}
		public function stringify():String
		{
			var res:String = '{';
			res += '"type":"' + type+'",';
			res += '"tags":"['+arrToString(tags.currentValue) +'],';
			res += '"audio":"['+arrToString(audio.currentValue)+'],';
			res += '"video":"['+arrToString(video.currentValue)+']';
			res += '}';
			return res;
			
			function arrToString(arr:Array):String
			{
				for (var i:int = 0; i < arr.length; i++) 
				{
					arr[i] = '"' + arr[i] + '"';
				}
				return String(arr);
				
			}
			
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
		public var type:String;
		public var tags:ArrayObserver = new ArrayObserver();
		public var level:IntegerObserver=new IntegerObserver(0);
		public var audio:ArrayObserver = new ArrayObserver();
		public var video:ArrayObserver = new ArrayObserver();

		
		public function Skill(skillTtype:String, data:Object=null) 
		{
			super(null);
			type = skillTtype;
			if (data) parse(data);
			
			tags.addListener(callUpdate);
			level.addListener(callUpdate);
			audio.addListener(callUpdate);
			video.addListener(callUpdate);
			
		}
		public function dispose() 
		{
			tags.removeListener(callUpdate);
			level.removeListener(callUpdate);
			audio.removeListener(callUpdate);
			video.removeListener(callUpdate);
		}
		private function callUpdate():void
		{
			update( null);
		}
		
		
	}

}