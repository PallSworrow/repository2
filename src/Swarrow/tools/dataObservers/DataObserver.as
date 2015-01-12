package Swarrow.tools.dataObservers {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author pall
	 */
	public class DataObserver extends EventDispatcher implements IdataObserver
	{
		private var getter:Function;
		private var setter:Function;
		private var parentObserver:DataObserver;
		private var binded:Boolean = false;
		
		private var _currentData:Object;
		public var signature:Object;
		public function DataObserver(value:Object) 
		{
			_currentData = value;
			super(this);
		}
		public function bindTo(getterFunc:Function, setterFunc:Function=null, observer:DataObserver=null):void
		{
			if (!(getterFunc is Function)) 
			{
				unbind();
				return;
			}
			else if (binded) unbind();
			
			binded = true;
			parentObserver = observer;
			if (parentObserver)
			parentObserver.addEventListener(Event.CHANGE, update);
			
			getter = getterFunc;
			setter = setterFunc;
		}
		public function unbind():void
		{
			if (!binded) return;
			_currentData = currentData;
			binded = false;
			if (parentObserver)
			parentObserver.removeEventListener(Event.CHANGE, update);
			parentObserver = null;
			getter = setter = null;
			
		}
		public function addListener(handler:Function):void
		{
			addEventListener(Event.CHANGE, handler);
		}
		public function removeListener(handler:Function):void
		{
			removeEventListener(Event.CHANGE,handler);
		}
		
		protected function update(e:Event = null)
		{
			dispatchEvent(new Event(Event.CHANGE));
			
		}
		
		protected function get currentData():Object 
		{
			
			if (binded)
			{
				if (parentObserver)
				{
					if (getter.length == 1) return getter(parentObserver.currentData);
					else throw new Error('При наличии наледуемого родителя, в геттер передается значение этого родителя');
				}
				else
				{
					switch(getter.length)
					{
						case 0:
							return getter();
						case 1:
							return getter(this);
							break;
						default:
							throw new Error('геттер должен принимать 0 или 1 аргумент');
							break;
					}
				}
				return null;//error
			}
			else
			return _currentData;
		}
		
		protected function set currentData(value:Object):void 
		{
			if (binded)
			{
				if (parentObserver)
				{
					if(setter is Function)
					{
						parentObserver.currentData = setter(value);
					}
				}
				else
				{
					switch(setter.length)
					{
						case 1:
							setter(value);
							break;
						case 2:
							setter(value, this);
							break;
						default:
							throw new Error('Сеттер должен принимать 1 или 2 аргумента');
							break;
					}
				}
			}
			else
			{
				_currentData = value;
				update();
			}
		}
		
		
	}

}