package Swarrow.tools.valueManagers.funcBased {
	import Swarrow.tools.valueManagers.interfaces.IstringValueManager;
	import flash.events.Event;
	import view.patternMagic.valueManagers.interfaces.IstringValueManager;
	/**
	 * ...
	 * @author 
	 */
	public class StringValueManager2 implements IstringValueManager
	{
		private var _getValue:Function;
		private var _setValue:Function;
		public function StringValueManager2(getter:Function,setter:Function) 
		{
			_getValue = getter;
			_setValue = setter;
		}
		public function setValue(value:String):void
		{
			_setValue(value);
			dispatchEvent(new Event('set'));
		}
		public function getValue():String
		{
			return String(_getValue());
		}
	}

}