package PS.controller 
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Timer;
	import PS.controller.events.ControllerEvent;
	import PS.controller.events.SwipeEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class SimpleController extends MixedController 
	{
		//PRIVATE CONSTS:
		private static const TapOccurancy:int = 20;
		private static const swipeMaxTime:int =200;
		private static const swipeMinDisntance:int = 35;
		
		//flags:
		private var swipeFlag:Boolean;
		private var swipeTimer:Timer;
		
		//public
		private var _lastSwipeDirection:String;
		public function SimpleController(target:InteractiveObject = null ) 
		{
			super();
			if(target) item = target
		}
		override protected function closeGes():void 
		{
			if (swipeTimer)
			{
				swipeTimer.stop();
				swipeTimer.removeEventListener(TimerEvent.TIMER, swipeTimer_timer);
				swipeTimer = null;
			}
			super.closeGes();
			
		}
		override protected function gesBegin(x:int, y:int):void 
		{
			super.gesBegin(x, y);
			swipeFlag = true;
			if (!swipeTimer) swipeTimer = new Timer(swipeMaxTime, 1);
			swipeTimer.start();
			swipeTimer.addEventListener(TimerEvent.TIMER, swipeTimer_timer);
			
			dispatchEvent(new ControllerEvent(ControllerEvent.ON_PRESS));
		}
		override protected function gesContinue(x:int, y:int):void 
		{
			super.gesContinue(x, y);
			dispatchEvent(new ControllerEvent(ControllerEvent.ON_MOVE));
		}
		private function swipeTimer_timer(e:TimerEvent):void 
		{
			swipeTimer.removeEventListener(TimerEvent.TIMER, swipeTimer_timer);
			swipeFlag = false;
			swipeTimer.stop();
		}
		override protected function gesEnd(x:int, y:int):void 
		{
			super.gesEnd(x, y);
			//check swipe:
			swipeTimer.removeEventListener(TimerEvent.TIMER, swipeTimer_timer);
			swipeTimer.stop();
			if (gesDistance < swipeMinDisntance) swipeFlag = false;
			if (gesDistance < gesLength * 0.7) swipeFlag = false;
			_lastSwipeDirection = null;
			if (swipeFlag)//swipe
			{
				var dir:String;
				if (lastX > startX + gesDistance * 0.6) dir = SwipeEvent.RIGHT;
				if (lastX < startX - gesDistance * 0.6) dir = SwipeEvent.LEFT;
				
				if (lastY > startY + gesDistance * 0.6) dir = SwipeEvent.DOWN;
				if (lastY < startY - gesDistance * 0.6) dir = SwipeEvent.UP;
				
				if (dir) 
				{
					_lastSwipeDirection = dir;
					dispatchEvent(new SwipeEvent(dir));
					dispatchEvent(new SwipeEvent(SwipeEvent.SWIPE, dir));
				}
				else swipeFlag = false;
				
			}
			else if (gesLength < TapOccurancy)//tap
			{
				
				dispatchEvent(new ControllerEvent(ControllerEvent.ON_TAP));
				if (_targetTrigger)
				{
					_targetTrigger.callHandler();
				}
			}
			else//no special events registered
			{
				dispatchEvent(new ControllerEvent(ControllerEvent.NO_GESS_RECONGIZED));
			}
			
			if(!swipeFlag) dispatchEvent(new SwipeEvent(SwipeEvent.FAILED));
			dispatchEvent(new ControllerEvent(ControllerEvent.ON_RELEASE));
			
		}
		
		public function get lastSwipeDirection():String 
		{
			return _lastSwipeDirection;
		}
		
		/*override public function dispatchEvent(event:Event):Boolean 
		{
			//if (event.type != 'move')
			trace('EVENT: ' + event.type);
			return super.dispatchEvent(event);
		}*/
	}

}