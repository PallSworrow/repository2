package PS.view.button {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import PS.controller.events.ControllerEvent;
	import PS.controller.SimpleController;
	import PS.view.button.interfaces.Ibtn;
	import PS.model.BaseSprite;
	
	
	/**
	 * ...
	 * @author 
	 */
	public class PsButton extends BaseSprite implements Ibtn 
	{
		//здесь областть видимости internal, чтобы класс ButtonGroup мог удобно добавлять кнопки без обращения к static спискам.
		//см ButtonGroup.addItem()
		internal var _group:BtnGroup;
		
		private var _isHandlerSet:Boolean = false;
		private var _handler:Function;
		private var _handlerParams:Object;
		
		private var _phaze:String = ButtonPhaze.DEFAULT;
		
		private var _viewHandlers:Object = {};
		protected var _viewElements:Object = { };
		
		
		private var ctrl:SimpleController;
		
		public function PsButton(addToGroup:String=null) 
		{
			if (addToGroup)group = addToGroup;
			
			//trace(this + ' group name: ' + group, _group);
			
			super();
			ctrl = new SimpleController();
			ctrl.item = this;
			ctrl.addEventListener(ControllerEvent.ON_TAP, ctrl_tap);
			_viewElements['root'] = this;
		}
		
		private function ctrl_tap(e:Event):void 
		{
			tap(true);
		}
	///CUSTOMIZATION FUNCS: ===================================================
	/**
	 * Добавляет именнованный объект в кнопку(для управления view phaze-ами) 
	 * Если уже был элемент с тем же именем - он будет удален 
	 * @param	element - ссылка на элемент(можно не делать addChild)
	 * @param	name - через это имя объект будет доступен в phazeHandler-е
	 * @return удаленный элемент (если был)
	 */
		public function addViewElement(element:DisplayObject, name:String):DisplayObject
		{
			if (name == 'root')
			{
				// TODO catch error - name "root" is reserved for button instance.
				return null;
			}
			var res:DisplayObject = _viewElements[name];
			if (res) removeChild(res);
			
			_viewElements[name] = element;
			addChild(element);
			
			return res;
			
		}
		public function getViewElement(name:String):DisplayObject
		{
			return _viewElements[name];
		}
		/**
		 * Устанавливает слушатель конкретной фазы кнопки
		 * В handler будет передан объект со списком именованных элементов + root(ссылка на саму кнопку)
		 * @param	viewPhaze - любая фаза из PsButton.ButtonPhaze
		 * @param	требуемый вид: phazeHandler(list:Object):void
		 */
		public function setViewHandler(viewPhaze:String, phazeHandler:Function):void
		{
			if (
			viewPhaze != ButtonPhaze.ACTIVE &&
			viewPhaze != ButtonPhaze.DEFAULT &&
			viewPhaze != ButtonPhaze.PRESSED )
			{
				// TODO catch wrong phaze value error 
				return;
			}
			_viewHandlers[viewPhaze] = phazeHandler;
			//update:
			if(_phaze == viewPhaze) _viewHandlers[_phaze](_viewElements);
		}
	
	
	
	
	//////////////////////////////////////////////////////////////////////
		
	///ENGINE: =========================================================
		/**
		 * Настройка визуального состояния. Не влияет на группу(!).
		 * Диспатчит событие ButtonEvent.PHAZE_CHANGED
		 * @param	value любая фаза из класса ButtonPhaze
		 */
		public function setPhaze(value:String):void
		{
			if (
			value != ButtonPhaze.ACTIVE &&
			value != ButtonPhaze.DEFAULT &&
			value != ButtonPhaze.PRESSED )
			{
				// TODO catch wrong phaze value error 
				return;
			}
			//applying view:
			_phaze = value;
			
			if (_viewHandlers[value])
			_viewHandlers[value](_viewElements);
			
			//dispatching view change:
			dispatchEvent(new Event(ButtonEvent.PHAZE_CHANGED));
		
			
		}
	
	
	///////////////////////////////////////////////////////////////////////
	
	
	//INTERFACE PS_starling.view._interfaces.Ibtn =====================================
		public function tap(callHandler:Boolean = true):void 
		{
			var prevPhaze:String = phaze;
			
			if (_group)
			{
				_group.tapItem(this);
				if (prevPhaze != phaze && phaze == ButtonPhaze.ACTIVE)
				{
					//is call handler required and possible:
					if (callHandler && isHandlerSet)
					{
						//params check:
						if (_handlerParams) _handler(_handlerParams);
						else _handler();
					}
					dispatchEvent(new Event(ButtonEvent.ON_TAP));
				}
			}
			else 
			{
				if (callHandler && isHandlerSet)
				{
					//params check:
					if (_handlerParams!=null) _handler(_handlerParams);
					else _handler();
				}
				dispatchEvent(new Event(ButtonEvent.ON_TAP));
			}
			
		}
		//setters:
		/**
		 * Кнопка может принадлежать только одной группе. При присвоении нового значения 
		 * она удаляется из старой старой группы, если такая была.
		 */
		public function set group(value:String):void 
		{
			if (value == group) return;
			
			if (!value)
			{
				BtnGroup.removeFromGroup(this);
				_group = null;
			}
			else
			{
				BtnGroup.addToGroup(value,this);
			}
			
		}
		/**
		 * Назначить слушатель Tap-дейсвтия(выбор кнопки щелчокм или программно)
		 * @param	
		 */
		public function setHandler(func:Function, params:Object = null ):void 
		{
			if (func is Function) 
			{
				_isHandlerSet = true;
				_handler = func;
				_handlerParams = params;
			}
			else
			{
				_isHandlerSet = false;
				_handler = null;
			}
		}
		
		//getters:
		/**
		 * Кнопка может принадлежать только одной группе. При присовении нового значения 
		 * она удаляется из старой старой группы, если такая была.
		 */
		public function get group():String 
		{
			if (_group) return _group.name;
			else return null;
		}
		public function get phaze():String 
		{
			return _phaze;
		}
		public function get isHandlerSet():Boolean 
		{
			return _isHandlerSet;
		}
		
	//////////////////////////////////////////////////////////////////////////////////	

		
	}

}