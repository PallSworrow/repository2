package PS.model.requestSystem.implementers 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.printing.PrintJob;
	import flash.system.LoaderContext;
	import PS.constants.VarName;
	import PS.model.interfaces.staff.IstringConverter;
	import PS.model.requestSystem.RequestImplementer;
	
	/**
	 * ...
	 * @author 
	 */
	public class ImgLoader extends RequestImplementer 
	{
		
		public function ImgLoader() 
		{
			super();
			
		}
		private var _linkFilter:IstringConverter;
		
		private var loader:Loader;
		private var request:URLRequest;
		//sprivate var 
		
		override protected function call(params:Object):void 
		{
			super.call(params);
			trace('CALL');
			loader = new Loader();
			
			var url:String = params[VarName.LINK] as String;
			if (_linkFilter) url = _linkFilter.convert(url);
			request = new URLRequest(url);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onFailed);
			loader.load(request,new LoaderContext(true));
			
		}
		
		/*override protected function pause():void 
		{
			super.pause();
		}
		override protected function resume():void 
		{
			super.resume();
		}*/
		override protected function abort():void 
		{
			killLoader();
		}
		override public function dispose():void 
		{
			killLoader();
			super.dispose();
		}
		//////////////////////////////////////////
		private function onLoaded(e:Event):void
		{
			var res:Object = { };
			res[VarName.DATA] = loader.content;
			res[VarName.SIZE] = loader.contentLoaderInfo.bytesLoaded;
			//res[VarName.METADATA] = loader.metaData;
			solve(true, res );
		}
		
		private function onFailed(e:IOErrorEvent):void
		{
			var res:Object = { };
			res[VarName.DATA] = 'error id: '+e.errorID;
			res[VarName.MESSAGE] = 'Ошибка загрузки фаила:' + request.url;
			solve(false, res );
		}
		private function killLoader():void
		{
			if (loader)
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onFailed);
				try
				{
					loader.close();
				}
				catch (e:Error) { }
			}
			loader = null;
			request = null;
		}
		//////////////////////////////////////////////////////////////////
		
		//CUSTOMIZE: ========================================================================
		public function get linkFilter():IstringConverter 
		{
			return _linkFilter;
		}
		
		public function set linkFilter(value:IstringConverter):void 
		{
			_linkFilter = value;
		}
	}

}