package Swarrow.tools.valueManagers.objectBased {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import Swarrow.tools.valueManagers.interfaces.IintValueManager;
	/**
	 * ...
	 * @author 
	 */
	public class IntValueManager extends EventDispatcher implements IintValueManager
	{
		
		private var source:Object;
		private var prop:String
		public function IntValueManager(sourceObject:Object,propertyName:String) 
		{
			source = sourceObject;
			prop = propertyName;
		}
		public function setValue(value:int):void
		{
			source[prop] = value;
			dispatchEvent(new Event('set'));
		}
		public function getValue():int
		{
			return int(source[prop]);
		}
		
	}

}