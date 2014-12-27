package Swarrow.tools.valueManagers.funcBased {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import Swarrow.tools.valueManagers.interfaces.IboolValueManager;
	/**
	 * ...
	 * @author 
	 */
	public class BooleanValueManager2 extends EventDispatcher implements IboolValueManager
	{
		private var _getValue:Function;
		private var _setValue:Function;
		public function BooleanValueManager2(getter:Function,setter:Function) 
		{
			_getValue = getter;
			_setValue = setter;
		}
		public function set flag(value:Boolean):void
		{
			_setValue(value);
			dispatchEvent(new Event('set'));
		}
		public function get flag():Boolean
		{
			return Boolean(_getValue());
		}
	}

}