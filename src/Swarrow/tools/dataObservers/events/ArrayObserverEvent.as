package Swarrow.tools.dataObservers.events 
{
	import flash.events.Event;
	import Swarrow.tools.dataObservers.ArrayObserver;
	
	/**
	 * ...
	 * @author pall
	 */
	public class ArrayObserverEvent extends Event 
	{
		public static const SET:String = 'set';
		public static const UPDATE:String = 'update';
		
		
		private var _newElenents:Array;
		private var _currenElements:Array;
		private var _removedElements:Array;
		public function ArrayObserverEvent(type:String, added:Object=null,removed:Object=null ) 
		{
			super(type);
			var prop:Object;
			_newElenents = [];
			_removedElements = [];
			if (added is Array)
			{
				for each(prop in added) _newElenents.push(prop);
			}
			else _newElenents.push(added);
			if (removed is Array)
			{
				for each(prop in removed) _removedElements.push(prop);
			}
			else _removedElements.push(removed);
		}
		public function get currentElements():Array
		{
			return (target as ArrayObserver).currentValue;
		}
		public function get removedElements():Array 
		{
			return _removedElements;
		}
		
		public function get newElenents():Array 
		{
			return _newElenents;
		}
		
	}

}