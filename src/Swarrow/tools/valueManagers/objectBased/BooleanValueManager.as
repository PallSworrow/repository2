package Swarrow.tools.valueManagers.objectBased {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import Swarrow.tools.valueManagers.interfaces.IboolValueManager;
	/**
	 * ...
	 * @author 
	 */
	public class BooleanValueManager extends EventDispatcher implements IboolValueManager
	{
		private var source:Object;
		private var prop:String
		public function BooleanValueManager(sourceObject:Object,propertyName:String) 
		{
			source = sourceObject;
			prop = propertyName;
		}
		public function setValue(value:Boolean):void
		{
			source[prop] = value;
			dispatchEvent(new Event('set'));
		}
		public function getValue():Boolean
		{
			return Boolean(source[prop]);
		}
	}

}