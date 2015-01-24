package model.profiles 
{
	import flash.events.Event;
	import model.constants.InstrumentType;
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
		public function parse(item:String):void//String->xml->skill
		{
			var inst:Skill = this;
			var xml:XML = XML(item);
			
			type = xml.type;
			level.currentValue = int(xml.level);
			
			parseList('tags');
			parseList('videos');
			parseList('audios');
			
			
			function parseList(propName:String):void
			{
				for each (var item:XML in xml.child(propName).item) 
				{
					inst[propName].push(String(item));
				}
			}
			
			
			//type = item.type;
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
			
		/*	for each(var prop:Object in item.tags)
			{
				tags.push(String(prop));
			}
			for each(var track:Object in item.audio)
			{
				audios.push(String(track));
			}
			for each(var link:Object in item.video)
			{
				videos.push(String(link));
			}
			level.currentValue = item.level;*/
			
		}
		public function stringify():String//skill->xml->string
		{
			var inst:Skill = this;
			//var res:String;
			var xml:XML = XML('<instrument></instrument>');
			
			xml.appendChild(XML('<type>'+type+'</type>'));
			xml.appendChild(XML('<level>' + level.currentValue+'</level>'));
			xml.appendChild(listToXml('tags'));
			xml.appendChild(listToXml('videos'));
			xml.appendChild(listToXml('audios'));
			//xml.appendChild(listToXml('skills'));
			
			return xml.toXMLString();
			function listToXml(propName:String):XML
			{
				var arr:ArrayObserver = inst[propName] as ArrayObserver;
				if (!arr) throw new Error('array property not found: ' + propName);
				var res:XML = XML('<' + propName+'></' + propName+'>');
				var l:int = arr.length
				for (var i:int = 0; i < l; i++) 
				{
					res.appendChild('<item>'+arr.getItem(i)+'</item>');
				}
				return res;
			}
			
			/*var res:String = '{';
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
				
			}*/
			
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
		public var audios:ArrayObserver = new ArrayObserver();
		public var videos:ArrayObserver = new ArrayObserver();

		
		public function Skill(data:String) 
		{
			super(null);
			if (InstrumentType.validate(data)) type = data;
			else if (data) parse(data);
			
			tags.addListener(callUpdate);
			level.addListener(callUpdate);
			audios.addListener(callUpdate);
			videos.addListener(callUpdate);
			
		}
		public function dispose() 
		{
			tags.removeListener(callUpdate);
			level.removeListener(callUpdate);
			audios.removeListener(callUpdate);
			videos.removeListener(callUpdate);
		}
		private function callUpdate(e:Event=null):void
		{
			update( null);
		}
		
		
	}

}