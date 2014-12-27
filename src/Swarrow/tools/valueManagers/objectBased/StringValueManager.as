package Swarrow.tools.valueManagers.objectBased {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import Swarrow.tools.valueManagers.interfaces.IstringValueManager;
	/**
	 * ...
	 * @author 
	 */
	public class StringValueManager extends EventDispatcher implements IstringValueManager
	{
		private var source:Object;
		private var prop:String;

		public function StringValueManager(sourceObject:Object,propertyName:String) 
		{
			source = sourceObject;
			prop = propertyName;
		}
		public function setValue(value:String):void
		{
			source[prop] = value;
			dispatchEvent(new Event('set'));
		}
		public function getValue():String
		{
			return String(source[prop]);
		}
	}

}