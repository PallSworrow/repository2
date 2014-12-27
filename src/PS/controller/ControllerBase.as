package PS.controller 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import PS.controller.triggers.ItriggerData;
	import PS.controller.triggers.TriggerData;
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	internal class ControllerBase extends EventDispatcher 
	{
		
		//MAIN VARS:
		private var _item:InteractiveObject;
		
		//GESTURE STATS:
		private var _startPoint:Point;
		private var _prevPoint:Point;
		private var _lastPoint:Point;
		
		private var _gesLength:int;
		private var _gesDistance:int;
		
		protected var _targetTrigger:TriggerData;
		private var targs:Array;
		private var triggers:Array = [];
		public function ControllerBase() 
		{
			
		}
		public function dispose():void
		{
			closeGes();
			_item = null;
		}
		//PROTECTED:
		//getters:
		public function get item():InteractiveObject 
		{
			return _item;
		}
		public function set item(value:InteractiveObject):void
		{
			_item = value;
		}
		//methods:
		private var _phaze:String;
		protected function gesBegin(x:int, y:int):void
		{
			closeGes();
			_phaze = 'begin';
			_startPoint = new Point(x, y);
			
			_gesLength = 0;
			_gesDistance = 0
			
			_prevPoint = _startPoint.clone();
			_lastPoint = _startPoint.clone();
			checkTriggers(_startPoint);
			
		}
		protected function gesContinue(x:int, y:int):void
		{
			
			var step:int;
			_phaze = 'continue';
			step = Math.sqrt(Math.pow(x-_lastPoint.x, 2) + Math.pow(y-_lastPoint.y, 2));
			_gesLength += step; 
			_gesDistance = Math.sqrt(Math.pow(x-_startPoint.x, 2) + Math.pow(y-_startPoint.y, 2));
			
			_prevPoint.x = _lastPoint.x;
			_prevPoint.y = _lastPoint.y;
			
			_lastPoint.x = x;
			_lastPoint.y = y;
		}
		protected function gesEnd(x:int, y:int):void
		{
			_phaze = 'end';
			gesContinue(x, y);
		}
		protected function closeGes():void
		{
			_phaze = null;
			_startPoint = null;
			_lastPoint = null;
			_gesDistance = 0;
			_gesLength = 0;
		}
		
		
		
		
		
		//PUBLIC:
		//add triggers to item:
		public function addTrigger(rect:Rectangle, handler:Function=null, params:Object = null, id:String=null):void
		{
			var trig:TriggerData = new TriggerData(handler);
			trig.id = id;
			trig.rectangle = rect;
			trig.data = params;
			triggers.push(trig);
		}
		public function addDispTrigger(disp:DisplayObject,handler:Function=null,  params:Object = null, id:String=null):void
		{
			if (!item) return;//error
			addTrigger(disp.getBounds(item), handler,params, id);
		}
		public function addElementTrigger(element:IviewElement, handler:Function = null, params:Object = null, id:String = null):void
		{
			if (!item) return;//error
			addTrigger(element.getBounds(item), handler,params, id);
		}
		
		public function removeTrigger(id:String):void
		{
			for (var i:int = triggers.length - 1; i >= 0; i--)
			{
				if (triggers[i].id == id) triggers.splice(i, 1);
			}
		}
		private function checkTriggers(globalTap:Point):void
		{
			if (!item) return;
			var rect:Rectangle;
			targs = [];
			_targetTrigger = null;
			var localP:Point = item.globalToLocal(globalTap);
			
			var trig:TriggerData;
			for (var i:int = 0; i < triggers.length;i++ ) 
			{
				trig = (triggers[i] as TriggerData);
				rect = trig.rectangle;
				if (
				localP.x >= rect.x &&
				localP.x <= rect.x + rect.width&&
				localP.y >= rect.y &&
				localP.y <= rect.y + rect.height)
				{
					//TAP TRIGGER!
					_targetTrigger = trig;
					targs.push(trig);
					
				}
			}
		}
		
		//getters:
		public function get startPoint():Point 
		{
			return _startPoint;
		}
		
		public function get lastPoint():Point 
		{
			return _lastPoint;
		}
		
		public function get gesLength():int 
		{
			return _gesLength;
		}
		
		public function get gesDistance():int 
		{
			return _gesDistance;
		}
		
		public function get startX():int
		{
			return startPoint.x;
		}
		public function get startY():int
		{
			return startPoint.y;
		}
		public function get lastX():int
		{
			return lastPoint.x;
		}
		public function get lastY():int
		{
			return lastPoint.y;
		}
		public function get targetTrigger():ItriggerData
		{
			return _targetTrigger;
		}
		public function get targTrigId():String
		{
			if (targetTrigger) return targetTrigger.id;
			else return null;
		}
		
		public function get phaze():String 
		{
			return _phaze;
		}
		
		public function get prevPoint():Point 
		{
			return _prevPoint;
		}
		public function getAllTargets():Array
		{
			return targs;
		}
		
	}

}