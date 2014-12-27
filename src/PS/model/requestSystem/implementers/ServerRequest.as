package PS.model.requestSystem.implementers 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import PS.constants.VarName;
	import PS.model.interfaces.staff.IstringConverter;
	import PS.model.requestSystem.RequestImplementer;
	
	/**
	 * ...
	 * @author 
	 */
	public class ServerRequest extends RequestImplementer 
	{
		private var req:URLRequest;
		private var loader:URLLoader;
		private var _domain:String;
		public function ServerRequest(domain:String=null) 
		{
			super();
			_domain = domain;
			//linkFilter = LinkFilter
			
		}
		override protected function call(params:Object):void 
		{
			super.call(params);
			//req = new URLRequest('https://api.instagram.com/v1/users/search?q=snowy&client_id=0606888fbe2948e190c6d0b79713fd3b');
			var url:String;
			
			var data:URLVariables = new URLVariables();
			for (var prop:String in params)
			{
				if (prop == VarName.LINK) url = params[prop];
				else data[prop] = params[prop];
			}
			if (!url) url = _domain;
			
			
			
			req = new URLRequest(url);
			req.data = data
			req.method = URLRequestMethod.GET;
			
			
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loader_complete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loader_ioError);
			loader.dataFormat = 'text/XML'//URLLoaderDataFormat.VARIABLES;
			loader.load(req);
		}
		private function loader_complete(e:Event):void 
		{
			loadComplete(loader.data);
		}
		private function loader_ioError(e:IOErrorEvent):void 
		{
			var res:Object = { };
			res[VarName.ERROR] = e.text;
			loadFailed( res);
			
		}
		//ANSWER:
		protected function loadComplete(params:Object):void 
		{
			solve(true, params);
		}
		protected function loadFailed(params:Object):void 
		{
			solve(false, params);
		}
		
		//ABORT:
		override protected function abort():void 
		{
			super.abort();
		}
		override public function dispose():void 
		{
			abort();
			super.dispose();
		}
		
		
		
		
	}

}