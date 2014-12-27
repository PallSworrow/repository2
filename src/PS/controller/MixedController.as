package PS.controller 
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author 
	 */
	internal class MixedController extends ControllerBase 
	{
		//STATIC FLAGS:
		
		//STATIC CONSTS:
		private static const MOUSE_EVENT:String = 'mouseevent';
		private static const TOUCH_EVENT:String = 'touchevent';
		private static const coolDown:int = 200;
		//=========================
		//flags:
		public var testName:String;
		private var _enabled:Boolean = false;
		private var _inProgress:Boolean = false;
		private var coolingDown:Boolean = false;
		public function MixedController() 
		{
			
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			super();
		}
		override public function get item():InteractiveObject 
		{
			return super.item;
		}
		
		override public function set item(value:InteractiveObject):void 
		{
			if (super.item == value) return;
			if (super.item)
			{
				enabled = false;
				closeGes();
				super.item = null;
			}
			if(value)
			{
				super.item = value;
				enabled = true;
			}
			else enabled = false;
		}
		public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void 
		{
			if (!item) 
			{
				_enabled = false;
				return;
			}
			if (_enabled == value) return;
			
			if (value)
			{
				
				item.addEventListener(MouseEvent.MOUSE_DOWN, item_mouseDown);
				item.addEventListener(TouchEvent.TOUCH_BEGIN, item_touchBegin);
				init();
			}
			else
			{
				disable();
				item.removeEventListener(MouseEvent.MOUSE_DOWN, item_mouseDown);
				item.removeEventListener(TouchEvent.TOUCH_BEGIN, item_touchBegin);
				closeGes();
				removeListeners();
				_inProgress = false;
			}
			_enabled = value;
		}
		override public function dispose():void 
		{
			enabled = false;
			super.dispose();
		}
		protected function init():void
		{
			
		}
		protected function disable():void
		{
			
		}
		private function get inProgress():Boolean 
		{
			return _inProgress;
		}
		
		private function set inProgress(value:Boolean):void 
		{
			if (_inProgress == value) return;
			//trace('set in Progress: ' + value);
			if (!value)
			{
				if (coolingDown) return;
				coolingDown = true;
				setTimeout(setInprogress, coolDown, value);
			}
			else
			{
				coolingDown = false;
				setInprogress(value);
			}
		}
		private function setInprogress(value:Boolean):void
		{
			coolingDown = false;
			_inProgress = value;
		}
	
		private var listeners:Boolean = false;
		//LISTEN EVENTS:
		//mouse events:
		private function item_mouseDown(e:MouseEvent):void 
		{
			//trace('mouse down can i?');
			if (!canI(MOUSE_EVENT)) return;
			
			var pt:Point = new Point(item.mouseX,item.mouseY);
			pt = item.localToGlobal(pt);
			gesBegin(pt.x,pt.y);
			listeners = true;
			item.stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
			item.stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUp);
		}
		private function stage_mouseMove(e:MouseEvent):void 
		{
			if (!listeners) return;
			//trace('mouse move');
			var pt:Point = new Point(item.mouseX,item.mouseY);
			pt = item.localToGlobal(pt);
			gesContinue(pt.x, pt.y);
		}
		private function stage_mouseUp(e:MouseEvent):void 
		{
			if (!listeners) return;
			//trace('mouse up');
			var pt:Point = new Point(item.mouseX,item.mouseY);
			pt = item.localToGlobal(pt);
			gesEnd(pt.x, pt.y);
		}
		
		//touch events:
		private function item_touchBegin(e:TouchEvent):void 
		{
			//trace('touch begin');
			if (!canI(TOUCH_EVENT)) return;
			listeners = true;
			gesBegin(e.stageX, e.stageY);
			item.stage.addEventListener(TouchEvent.TOUCH_MOVE, item_touchMove);
			item.stage.addEventListener(TouchEvent.TOUCH_END, stage_touchEnd);
			
		}
		private function item_touchMove(e:TouchEvent):void 
		{
			if (!listeners) return;
			gesContinue(e.stageX, e.stageY);
		}
		private function stage_touchEnd(e:TouchEvent):void 
		{
			if (!listeners) return;
			gesEnd(e.stageX, e.stageY);
		}
		
		
		//OVERRIDES:
		override protected function gesEnd(x:int, y:int):void 
		{
			super.gesEnd(x, y);
			removeListeners();
			inProgress = false;
		}
		override protected function closeGes():void 
		{
			inProgress = false;
			removeListeners();
			super.closeGes();
		}
		private function removeListeners():void
		{
			if (!item.stage) return;
			//trace('REMOVE LISTENERS:');
			listeners = false;
			item.stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
			item.stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUp);
			
			item.stage.removeEventListener(TouchEvent.TOUCH_MOVE, item_touchMove);
			item.stage.removeEventListener(TouchEvent.TOUCH_END, stage_touchEnd);
			
			
		}
		
		//RESTRICTIONS:
		private function canI(eventType:String):Boolean
		{
			if (inProgress) return false;
			
			inProgress = true;
			return true;
		}
		
	}

}