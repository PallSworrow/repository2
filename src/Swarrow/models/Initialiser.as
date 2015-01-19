package Swarrow.models 
{
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author 
	 */
	public class Initialiser 
	{
		private static var inited:Boolean = false;
		private var onComplete:Function;
		public function Initialiser(width:int, height:int, stage:Stage)
		{
			if (inited) throw new Error('already inited');
			inited = true;
			
			Globals._width = width;
			Globals._height = height;
			Globals._stage = stage;
		}
		public function init( completeHandler:Function,config:String=null):void
		{
			onComplete = completeHandler;
			if (config)
			{
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, loader_complete);
				loader.load(new URLRequest(config));
			}
			else onComplete();
		}
		private function loader_complete(e:Event):void 
		{
			readConfig(e.target.data);
			onComplete();
		}
		
		protected function readConfig(data:Object):void
		{
			
		}
	}

}