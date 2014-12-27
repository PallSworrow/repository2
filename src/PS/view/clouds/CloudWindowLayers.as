package PS.view.clouds 
{
	import flash.display.Stage;
	/**
	 * ...
	 * @author 
	 */
	public class CloudWindowLayers
	{
		
		public static var defaultCloudsStage:Stage;
		public static function addLayer(name:String, stage:Stage):void
		{
			layers[name] = stage;
		}
		public static function removeLayer(name:String):void
		{
			delete layers[name];
		}
		private static var layers:Object = { };
		
		public static function getLayer(name:String):Stage
		{
			
			return layers[name];
		}
		
		
	}

}