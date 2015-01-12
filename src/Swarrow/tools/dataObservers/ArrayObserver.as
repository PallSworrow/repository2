package Swarrow.tools.dataObservers {
	import flash.events.Event;
	import Swarrow.tools.dataObservers.events.ArrayObserverEvent;
	/**
	 * ...
	 * @author pall
	 */
	public class ArrayObserver extends DataObserver implements IdataObserver
	{
		
		private var _prevValue:Array;
		public function ArrayObserver(value:Array=null) 
		{
		
			if (!value) value = [];
			super(value);
			updateSubListeners();
		}
		override public function bindTo(getterFunc:Function, setterFunc:Function = null, observer:DataObserver = null):void 
		{
			throw new Error('Binding array observers is not supported for now');
		}
		protected function get _currentValue():Array
		{
			return currentData as Array;
		}
		protected function set _currentValue(value:Array):void
		{
			currentData = value;
		}
		private function dispatchAOE(type:String, added:Object = null, removed:Object = null):void
		{
			dispatchEvent(new ArrayObserverEvent(type, added, removed));
		}
		private function listenToItem(item:Object):void
		{
			if (item is IdataObserver) 
			{
				(item as IdataObserver).addListener(update);
			}
		}
		private function stopListeningItem(item:Object):void
		{
			if (item is IdataObserver) 
			{
				(item as IdataObserver).removeListener(update);
			}
		}
		private function updateSubListeners():void
		{
			var item:Object;
			for (var i:int = _currentValue.length - 1;i>=0; i--) 
			{
				listenToItem(_currentValue[i]);	
			}
		}
		private function removeSubListeners():void
		{
			var item:Object;
			for (var i:int = _currentValue.length - 1;i>=0; i--) 
			{
				stopListeningItem(_currentValue[i]);
			}
		}
		public function getItem(index:int):Object
		{
			return _currentValue[index];
		}
		public function get currentValue():Array
		{
			return _currentValue.slice();//returns a clone
		}
		public function set currentValue(value:Array):void 
		{
			removeSubListeners();
			_prevValue = _currentValue;
			_currentValue = value;
			//update();
			dispatchAOE(ArrayObserverEvent.SET);
			updateSubListeners();
		}
		public function push(item:Object):void
		{
			_prevValue = currentValue;
			_currentValue.push(item);
			update();
			dispatchAOE(ArrayObserverEvent.PUSH,item);
			listenToItem(item);
		}
		public function unshift(item:Object):void
		{
			_prevValue = currentValue;
			_currentValue.unshift(item);
			update();
			dispatchAOE(ArrayObserverEvent.UNSHIFT,item);
			listenToItem(item);
		}
		public function pop():Object
		{
			_prevValue = currentValue;
			var res:Object = _currentValue.pop();
			update();
			dispatchAOE(ArrayObserverEvent.POP,res);
			stopListeningItem(res);
			return res;
		}
		public function shift():Object
		{
			_prevValue = currentValue;
			var res:Object = _currentValue.shift();
			update();
			dispatchAOE(ArrayObserverEvent.SHIFT,res);
			stopListeningItem(res);
			return res;
		}
		public function get length():int
		{
			return _currentValue.length;
		}
		
		public function get prevValue():Array 
		{
			return _prevValue.slice();
		}
		
		public function splice(from:int, length:int=1):void
		{
			_prevValue = currentValue;
			if (length >= _currentValue.length) length = _currentValue.length - 1;
			for (var i:int = length; i >= 0; i--) 
			{
				stopListeningItem(_currentValue[i + length]);
			}
			var removes:Array = _currentValue.splice(from, length);
			dispatchAOE(ArrayObserverEvent.SPLICE, removes);
			update();
		}
		
		
	}

}