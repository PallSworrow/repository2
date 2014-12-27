package PS.model 
{
	import flash.display.DisplayObjectContainer;
	import PS.model.popupSystem.PopupEngine;
	import PS.view.clouds.CloudWindowLayers;
	/**
	 * ...
	 * @author 
	 */
	public class Engine 
	{
		
		public static function get inst():Engine 
		{
			if (!_inst) _inst = new Engine();
			return _inst;
			
		}
		private static var _inst:Engine;
		
		
		
		
		
		
		public function Engine() 
		{
			if (_inst) throw Error('double engine init');
		}
		public function init(w:int, h:int, stage:DisplayObjectContainer):void
		{
			Globals.init(w, h);
			CloudWindowLayers.defaultCloudsStage = stage.stage;
			if (!PopupEngine.container) PopupEngine.container = stage;
			
		}
		
	}

}