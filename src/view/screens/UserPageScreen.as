package view.screens 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import model.profiles.interfaces.IskillProfile;
	import model.profiles.MusicianProfile;
	import model.profiles.Skill;
	import PS.model.interfaces.IviewElement;
	/**
	 * ...
	 * @author ...
	 */
	public class UserPageScreen extends MusicianProfileScreen 
	{
		
		public function UserPageScreen() 
		{
			super(false);
			
		}
		
		private function save(e:Event=null):void 
		{
			trace('SAVE:',MusicianProfile.stringify(profile));
			var loader:URLLoader = new URLLoader();
			var req:URLRequest = new URLRequest('http://allmusiciants.freevar.com/saveProfile.php')
			var vars:URLVariables = new URLVariables();
			vars['city'] = profile.city;
			vars['cityChangeReady'] = profile.cityChangeReady;
			vars['countryChangeReady'] = profile.countryChangeReady;
			//vars['getInstrumentTypes'] = profile.getInstrumentTypes;
			vars['goals'] = toJsonArrayString(profile.goals);
			//vars['groupSearchReqs'] = toJsonArrayString(profile.groupSearchReqs);
			vars['id'] = profile.id;
			vars['info'] = profile.info;
			vars['instruments'] = stringifyInstProfs(profile.instruments);
			vars['isMusician'] = profile.isMusician;
			vars['localTours'] = profile.localTours;
			vars['localToursReady'] = profile.localToursReady;
			vars['name'] = profile.name;
			vars['passport'] = profile.passport;
			vars['photos'] = toJsonArrayString(profile.photos);
			vars['searchForGroup'] = profile.searchForGroup;
			vars['searchForMusician'] = profile.searchForMusician;
			vars['stageExperience'] = profile.stageExperience;
			vars['styles'] = toJsonArrayString(profile.styles);
			//vars['userSearchReqs'] = toJsonArrayString(profile.userSearchReqs);
			vars['worldTours'] = profile.worldTours;
			vars['worldToursReady'] = profile.worldToursReady;
			vars['writeExperience'] = profile.writeExperience;
			//vars[''] = profile.;
			req.data = vars;
			req.method = URLRequestMethod.POST;
			loader.addEventListener(Event.COMPLETE, loader_complete);
			loader.load(req);
			function stringifyInstProfs(vec:Vector.<IskillProfile>):String
			{
				var res:Array = [];
				for each(var prop:Skill in vec)
				{
					res.push(JSON.stringify(prop));
				}
				return res.join(',');
				
			}
			function toJsonArrayString(vec:Vector.<String>):String
			{
				var res:Array = [];
				for each(var prop:String in vec) res.push('"' + prop + '"');
				return res.join(',');
				
			}
		}
		
		private function loader_complete(e:Event):void 
		{
			trace(this, 'saved\n', e.target.data);
		}
		override protected function createListModule(data:Object):IviewElement 
		{
			data.editable = true;
			data.manager.addEventListener('set', save);
			return super.createListModule(data);
		}
		override protected function createCheckBox(data:Object):IviewElement 
		{
			data.editable = true;
			data.manager.addEventListener('set', save);
			return super.createCheckBox(data);
		}
		override protected function createPhotos(data:Object):IviewElement 
		{
			data.editable = true;
			data.manager.addEventListener('set', save);
			return super.createPhotos(data);
		}
		override protected function createText(data:Object):IviewElement 
		{
			data.editable = true;
			data.manager.addEventListener('set', save);
			return super.createText(data);
		}
	}

}