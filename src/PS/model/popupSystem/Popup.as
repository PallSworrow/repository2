package PS.model.popupSystem {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import PS.model.interfaces.IviewElement;
	/**
	 * ...
	 * @author 
	 */
	public class Popup extends EventDispatcher implements Ipopup
	{
		private var _inst:Sprite
		private var _isShown:Boolean = false;
		private var _data:Object = { };
		public function Popup() 
		{
			
		}
		public function dispose():void 
		{
			close();
		}
		
		//internal:
		//Методы доступные только для PopupEngine:
		internal function addTo(container:DisplayObjectContainer):void
		{
			container.addChild(_inst);
			onDisplayed();
			dispatchEvent(new Event(PopupEvent.ON_DISPLAYED));
		}
		internal function remove(container:DisplayObjectContainer):void
		{
			onRemoved();
			container.removeChild(_inst);
			dispatchEvent(new Event(PopupEvent.ON_REMOVED));
		}
		
		/* INTERFACE PS_starling.model.popupSystem.Ipopup */
		
		public function show(parameters:Object=null):void 
		{
			if (isShown) return;
			_isShown = true;
			_inst = new Sprite();
			dispatchEvent(new Event(PopupEvent.ON_SHOWCALL));
			PopupEngine.addPopup(this);
		}
		
		public function close(parameters:Object=null):void 
		{
			if (!isShown)  return;
			_isShown = false;
			
			dispatchEvent(new Event(PopupEvent.ON_CLOSECALL));
			PopupEngine.closePopup(this);
			
			_inst = null;
		}
		
		/* INTERFACE PS.model.popupSystem.Ipopup */
		
		public function setParameter(name:String, value:Object):void 
		{
			data[name] = value;
		}
		
		public function getParameter(name:String):Object 
		{
			return data[name];
		}
		
		public function get isShown():Boolean 
		{
			return _isShown;
		}
		
		//PROTECTED:
		//displayobject interaction:
		protected function addChild(child:DisplayObject):void
		{
			if (_inst)_inst.addChild(child);
			else 
			{
				// TODO error child can be added only after show() call;
				throw new Error('You can not add childs before show() method call');
			}
		}
		protected function removeChild(child:DisplayObject):void
		{
			if (_inst)_inst.removeChild(child);
			else 
			{
				throw new Error('after close() all child are already removed');
			}
		}
		protected function addElement(element:IviewElement):void
		{
			if (_inst)element.addTo(_inst);
			else 
			{
				// TODO error child can be added only after show() call;
				throw new Error('You can not add childs before show() method call');
			}
		}
		protected function removeElement(element:IviewElement):void
		{
			if (_inst) element.remove();
			else 
			{
				throw new Error('after close() all child are already removed');
			}
		}
		
		//other methods:
		protected function get data():Object 
		{
			return _data;
		}
		
		
		protected function onDisplayed():void
		{
		}
		protected function onRemoved():void
		{
		}
		
		
		
	}

}