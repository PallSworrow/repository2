package model.connection 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import model.Data;
	import model.profiles.interfaces.Iparsable;
	import model.profiles.MusicianProfile;
	import Swarrow.tools.dataObservers.ArrayObserver;
	import Swarrow.tools.dataObservers.BooleanObserver;
	import Swarrow.tools.dataObservers.IntegerObserver;
	import Swarrow.tools.dataObservers.StringObserver;
	import Swarrow.tools.TypeDescriptor;
	/**
	 * ...
	 * @author pall
	 */
	public class ServerConnection 
	{
		private static const SERVER:String = 'http://allmusiciants.freevar.com/';
		public static function loadIntialData(onComplete:Function, onError:Function=null):void
		{
			//am init
		}
		public static function getViewerLocalData(onComplete:Function, onError:Function=null):void
		{
			//am init
		}
		public static function logIn(viewerID:String, onComplete:Function, onError:Function=null):void
		{
			//am init
		}
		public static function search(req:String, onComplete:Function, onError:Function=null):void
		{
			
		}
		public static function saveProfile(prof:MusicianProfile, onComplete:Function, onError:Function=null):void
		{
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, onComplete);
			var req:URLRequest = new URLRequest(SERVER+'saveProfile.php');
			var vars:URLVariables = new URLVariables();
			vars['id'] = Data.viewerId;
			
			var res:String;
			var str:String;
			var elts:Array;
			TypeDescriptor.iterateVars(prof, null,
			function(name:String, type:Class, value:Object):void
			{
				if (!value) return;
				switch(type)
				{
					case IntegerObserver:
						vars[name] = String(value.currentValue);
						break;
					case StringObserver:
						vars[name] = String(value.currentValue);
						break;
					case BooleanObserver:
						if (value.currentValue)
						vars[name] = '1';
						else
						vars[name] = '0';
						break;
					case ArrayObserver:
						elts = [];
						for each(var item:Object in value.currentValue)
						{
							if (item is Iparsable)
							elts.push((item as Iparsable).stringify());
							else
							elts.push(item);
						}
						vars[name] = elts.join(', ');
						break;
						
				}
			});
			req.method = URLRequestMethod.POST;
			req.data = vars;
			loader.load(req);
		}
		
		
		
		public function ServerConnection() 
		{
			
		}
		
	}

}