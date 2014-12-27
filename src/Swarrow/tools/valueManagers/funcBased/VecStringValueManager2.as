package Swarrow.tools.valueManagers.funcBased {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import Swarrow.tools.valueManagers.interfaces.IvecStringValueManager;
	/**
	 * ...
	 * @author 
	 */
	public class VecStringValueManager2 extends EventDispatcher implements IvecStringValueManager
	{
		
		private var _getValue:Function;
		private var _setValue:Function
		public function VecStringValueManager2(getter:Function,setter:Function) 
		{
			_getValue = getter;
			_setValue = setter;
		}
		public function setValue(value:Vector.<String>):void
		{
			_setValue(value);
			dispatchEvent(new Event('set'));
		}
		public function getValue():Vector.<String>
		{
			return Vector.<String>(_getValue());
		}
	}

}