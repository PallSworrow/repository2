package Swarrow.tools.valueManagers.objectBased {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import Swarrow.tools.valueManagers.interfaces.IvecStringValueManager;
	/**
	 * ...
	 * @author 
	 */
	public class VecStringValueManager extends EventDispatcher implements IvecStringValueManager
	{
		
		private var source:Object;
		private var prop:String
		public function VecStringValueManager(sourceObject:Object,propertyName:String) 
		{
			source = sourceObject;
			prop = propertyName;
		}
		public function setValue(value:Vector.<String>):void
		{
			source[prop] = value;
			dispatchEvent(new Event('set'));
		}
		public function getValue():Vector.<String>
		{
			return Vector.<String>(source[prop]);
		}
		
	}

}