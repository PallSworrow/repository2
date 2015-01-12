package model.profiles 
{
	import adobe.utils.CustomActions;
	import model.profiles.interfaces.IgroupSearchRequest;
	import model.profiles.interfaces.IsearchRequest;
	import model.profiles.interfaces.IuserSearchRequest;
	import model.profiles.interfaces.ImusicianProfile;
	import model.profiles.interfaces.IskillProfile;
	import PS.model.dataProcessing.profiles.UserProfile;
	import Swarrow.tools.dataObservers.ArrayObserver;
	import Swarrow.tools.dataObservers.BooleanObserver;
	import Swarrow.tools.dataObservers.IntegerObserver;
	import Swarrow.tools.dataObservers.StringObserver;
	
	/**
	 * ...
	 * @author 
	 */
	public class MusicianProfile
	{
		public function parse(str:String):void
		{
			var obj:Object = JSON.parse(str);
			id = obj.id;
			name.currentValue = obj.name;
			city.currentValue = obj.city;
			searchForMusician.currentValue = (obj.searchForMusician ==1);
			searchForGroup.currentValue = (obj.searchForGroup == 1);
			photos.currentValue = [];
			for each(var pic:Object in obj.photos) photos.push(String(pic));
			styles.currentValue = [];
			for each(var style:Object in obj.styles) styles.push(String(style));
			info.currentValue = String(obj.info);
			
			instruments.currentValue = [];
			if (obj.instruments is String) obj.instruments = JSON.parse(obj.instruments);
			for each(var skill:Object in obj.instruments)
			{
				try
				{instruments.push(new Skill('',skill)); }
				catch (e:Error){}
			}
			stageExperience.currentValue = obj.stageExperience;
			writeExperience.currentValue = obj.writeExperinece;
			localTours.currentValue = (obj.localTours == 1);
			worldTours.currentValue = (obj.worldTours ==1);
			localToursReady.currentValue = (obj.localToursReady ==1);
			worldToursReady.currentValue = (obj.worldToursReady ==1);
			cityChangeReady.currentValue = (obj.cityChangeReady ==1);
			countryChangeReady.currentValue = (obj.countryChangeReady ==1);
			passport.currentValue = (obj.passport ==1);
		}
		public function stringify():String
		{
			var arr:Array = [];
			arr.push(addStringProp('id', id));
			arr.push(addStringProp('name', name.currentValue));
			arr.push(addStringProp('city', city.currentValue));
			arr.push(addBoolProp('searchForMusician', searchForMusician.currentValue));
			arr.push(addBoolProp('searchForGroup', searchForGroup.currentValue));
			arr.push(addListProp('photos', photos.currentValue));
			arr.push(addListProp('styles', styles.currentValue));
			arr.push(addListProp('goals', goals.currentValue));
			arr.push(addStringProp('info', info.currentValue));
			arr.push(addListProp('instruments', instruments.currentValue));
			arr.push(addBoolProp('localTours', localTours.currentValue));
			arr.push(addBoolProp('worldTours', worldTours.currentValue));
			arr.push(addBoolProp('localToursReady', localToursReady.currentValue));
			arr.push(addBoolProp('worldToursReady', worldToursReady.currentValue));
			arr.push(addBoolProp('cityChangeReady', cityChangeReady.currentValue));
			arr.push(addBoolProp('countryChangeReady', countryChangeReady.currentValue));
			arr.push(addBoolProp('passport', passport.currentValue));
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
		public var name:StringObserver=new StringObserver();
		public var city:StringObserver = new StringObserver();
		public var searchForMusician:BooleanObserver = new BooleanObserver(false);
		public var searchForGroup:BooleanObserver = new BooleanObserver(false);
		public var userSearchReq:ArrayObserver = new ArrayObserver();
		public var groupSearchReqs:ArrayObserver = new ArrayObserver();
		public var photos:ArrayObserver = new ArrayObserver();
		public var styles:ArrayObserver = new ArrayObserver();
		public var goals:ArrayObserver = new ArrayObserver();
		public var info:StringObserver = new StringObserver();
		public var instruments:ArrayObserver = new ArrayObserver(); 
		public var stageExperience:IntegerObserver = new IntegerObserver(0);
		public var writeExperience:IntegerObserver = new IntegerObserver(0);
		public var localTours:BooleanObserver = new BooleanObserver(false);
		public var worldTours:BooleanObserver = new BooleanObserver(false);
		public var localToursReady:BooleanObserver = new BooleanObserver(false);
		public var worldToursReady:BooleanObserver = new BooleanObserver(false);
		public var cityChangeReady:BooleanObserver = new BooleanObserver(false);
		public var countryChangeReady:BooleanObserver = new BooleanObserver(false);
		public var passport:BooleanObserver = new BooleanObserver(false);
		
		
		public var isMusician:BooleanObserver=new BooleanObserver(false);
		
		public function MusicianProfile(data:String = null ) 
		{
			super();
			if(data) 
			parse(data);
		}
	
		public function getInstrumentTypes():Vector.<String>
		{
			var res:Vector.<String> = new Vector.<String>;
			//trace(this, 'getInstrumentTypes');
			var arr:Array = instruments.currentValue;
			for each(var instrument:IskillProfile in arr)
			{
				//trace(instrument.type);
				res.push(instrument.type);
			}
			return res;
		}
		
	}

}