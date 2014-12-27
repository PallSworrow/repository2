package model.profiles 
{
	import adobe.utils.CustomActions;
	import model.profiles.interfaces.IgroupSearchRequest;
	import model.profiles.interfaces.IsearchRequest;
	import model.profiles.interfaces.IuserSearchRequest;
	import model.profiles.interfaces.ImusicianProfile;
	import model.profiles.interfaces.IskillProfile;
	import PS.model.dataProcessing.profiles.UserProfile;
	
	/**
	 * ...
	 * @author 
	 */
	public class MusicianProfile
	{
		public static function parse(str:String):MusicianProfile
		{
			var res:MusicianProfile = new MusicianProfile();
			//trace(str);
			var obj:Object = JSON.parse(str);
			//res.isMusician = obj.isMusiciant;
			res.id = obj.id;
			res.name = obj.name;
			res.city = obj.city;
			if(obj.searchForMusician ==1)res.searchForMusician = true;
			if(obj.searchForGroup == 1) res.searchForGroup = true;
			//for each(var mreq:Object in obj.s4mReqs) res.photoUrl.push(String(mreq));
			//for each(var greq:Object in obj.s4gReqs) res.instruments.push(Skill.parse(greq));
			for each(var pic:Object in obj.photos) res.photos.push(String(pic));
			for each(var style:Object in obj.styles) res.styles.push(String(style));
			//for each(var goal:Object in obj.goals) res.styles.push(String(style));
			res.info = obj.info;
			if (obj.instruments is String) obj.instruments = JSON.parse(obj.instruments);
			for each(var skill:Object in obj.instruments)
			{
				try
				{res.instruments.push(Skill.parse(skill)); }
				catch (e:Error){}
			}
			res.stageExperience = obj.stageExperience;
			res.writeExperience = obj.writeExperinece;
			if (obj.localTours == 1) res.localTours = true;
			if(obj.worldTours ==1)res.worldTours = true;
			if(obj.localToursReady ==1)res.localToursReady =true;
			if(obj.worldToursReady ==1)res.worldToursReady = true;
			if(obj.cityChangeReady ==1)res.cityChangeReady = true;
			if(obj.countryChangeReady ==1)res.countryChangeReady = true;
			if(obj.passport ==1)res.passport = true;
			
			return res;
		}
		public static function stringify(prof:MusicianProfile):String
		{
			var arr:Array = [];
			arr.push(addStringProp('id', prof.id));
			arr.push(addStringProp('name', prof.name));
			arr.push(addStringProp('city', prof.city));
			arr.push(addBoolProp('searchForMusician', prof.searchForMusician));
			arr.push(addBoolProp('searchForGroup', prof.searchForGroup));
			//arr.push('"userReqs":'+JSON.stringify(prof.userSearchReqs));
			//arr.push('"groupReqs":' + JSON.stringify(prof.groupSearchReqs));
			arr.push(addListProp('photos', prof.photos));
			arr.push(addListProp('styles', prof.styles));
			arr.push(addListProp('goals', prof.goals));
			arr.push(addStringProp('info', prof.info));
			arr.push(addListProp('instruments', prof.instruments));
			
			arr.push(addBoolProp('localTours', prof.localTours));
			arr.push(addBoolProp('worldTours', prof.worldTours));
			arr.push(addBoolProp('localToursReady', prof.localToursReady));
			arr.push(addBoolProp('worldToursReady', prof.worldToursReady));
			arr.push(addBoolProp('cityChangeReady', prof.cityChangeReady));
			arr.push(addBoolProp('countryChangeReady', prof.countryChangeReady));
			arr.push(addBoolProp('passport', prof.passport));
			
			
			return '{' + arr.join(',') + '}';
			
			function addStringProp(name:String, value:String):String
			{
				return '"'+name+'":{ "value":"' + value+'", "type":"string"}';
			}
			function addNumberProp(name:String, value:Number):String
			{
				return '"'+name+'":{ "value":"' + value+'", "type":"numnber"}';
			}
			function addListProp(name:String, value:Object):String
			{
				if (value.length == 0) return '"' + name+'":{ "value":"", "type":"list"}';
				
				return '"'+name+'":{ "value":' + JSON.stringify(value)+', "type":"list"}';
			}
			function addBoolProp(name:String, value:Boolean):String
			{
				var res:int=0;
				if (value) res = 1;
				return '"'+name+'":{ "value":' + res+', "type":"bool"}';
			}
		}
		
		public var id:String;
		public var name:String='';
		public var city:String = '';
		public var searchForMusician:Boolean = false;
		public var searchForGroup:Boolean = false;
		public var userSearchReqs:Vector.<IuserSearchRequest> = new Vector.<IuserSearchRequest>;
		public var groupSearchReqs:Vector.<IgroupSearchRequest> = new Vector.<IgroupSearchRequest>;
		public var photos:Vector.<String> = new Vector.<String>;
		public var styles:Vector.<String> = new Vector.<String>;
		public var goals:Vector.<String> = new Vector.<String>;
		public var info:String;
		public var instruments:Vector.<IskillProfile> = new Vector.<IskillProfile>;
		public var stageExperience:int = 0;
		public var writeExperience:int = 0;
		public var localTours:Boolean = false;
		public var worldTours:Boolean = false;
		public var localToursReady:Boolean = false;
		public var worldToursReady:Boolean = false;
		public var cityChangeReady:Boolean = false;
		public var countryChangeReady:Boolean = false;
		public var passport:Boolean = false;
		
		
		public var isMusician:Boolean=false;
		
		public function MusicianProfile() 
		{
			super();
			
		}
	
		public function getInstrumentTypes():Vector.<String>
		{
			var res:Vector.<String> = new Vector.<String>;
			//trace(this, 'getInstrumentTypes');
			for each(var instrument:IskillProfile in instruments)
			{
				//trace(instrument.type);
				res.push(instrument.type);
			}
			return res;
		}
		
	}

}