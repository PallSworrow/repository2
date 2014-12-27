package PS.controller 
{
	import com.greensock.TweenMax;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import PS.controller.events.DragEvent;
	import PS.controller.events.SwipeEvent;
	/**
	 * ...
	 * @author 
	 */
	public class DragController extends SimpleController
	{
		private var rect:Rectangle;
		private var _swipeForce:Number = 0.3;
		private var _tweenTime:Number = 0.6;
		
		
		private var tween:TweenMax;
		public function DragController(dragRectangle:Rectangle) 
		{
			super();
			rect = dragRectangle
			
			
			
			
			
		}
		override public function dispose():void 
		{
			if (tween) tween.kill();
			tween = null;
			rect = null;
			super.dispose();
		}
		override protected function init():void 
		{
			super.init();
			addEventListener(SwipeEvent.SWIPE, swipe);
			addEventListener(SwipeEvent.FAILED, swipeFail);
			update();
			
			
		}
		override protected function disable():void 
		{
			super.disable();
			removeEventListener(SwipeEvent.SWIPE, swipe);
			removeEventListener(SwipeEvent.FAILED, swipeFail);
		}
		
		
		public function drop():void
		{
			trace('DROP');
			closeGes();
		}
		
		//ENGINE:
		public function update():void
		{
			if (item.x  > rect.x + rect.width) item.x = rect.x + rect.width;
			else if (item.x  < rect.x) item.x = rect.x;
			if (item.y  > rect.y + rect.height) item.y = rect.y + rect.height;
			else if (item.y < rect.y) item.y = rect.y;
		}
		override protected function gesBegin(x:int, y:int):void 
		{
			if (tween) 
			{
				tween.kill();
				tween = null;
			}
			super.gesBegin(x, y);
			dispatchEvent(new DragEvent(DragEvent.ON_GRAB));
		}
		override protected function gesContinue(x:int, y:int):void 
		{
			
			var stepX:int = x - lastX;
			var stepY:int = y - lastY;
			
			if (item.x +stepX > rect.x + rect.width) item.x = rect.x + rect.width;
			else if (item.x + stepX < rect.x) item.x = rect.x;
			else item.x += stepX;
			
			if (item.y +stepY > rect.y + rect.height) item.y = rect.y + rect.height;
			else if (item.y + stepY < rect.y) item.y = rect.y;
			else item.y += stepY;
			
			super.gesContinue(x, y);
			
			dispatchEvent(new DragEvent(DragEvent.ON_DRAG));
		}
		private function swipe(e:SwipeEvent):void 
		{
			var res:int;
			if (swipeForce == 0)
			{
				dropComplete();
				return;
			}
			switch(e.direction)
			{
				case 'left':
					res = item.x - rect.width * _swipeForce;
					if (res < rect.x) res = rect.x;
					tween = TweenMax.to(item, _tweenTime, { x:res, onUpdate:dispatchTweening,onComplete:dropComplete} );
					break;
				case 'right':
					res = item.x + rect.width * _swipeForce;
					if (res > rect.x+rect.width) res = rect.x+rect.width;
					tween = TweenMax.to(item, _tweenTime, { x:res, onUpdate:dispatchTweening,onComplete:dropComplete } );
					break;
				case 'up':
					res = item.y - rect.height * _swipeForce;
					if (res < rect.y) res = rect.y;
					tween = TweenMax.to(item, _tweenTime, { y:res , onUpdate:dispatchTweening,onComplete:dropComplete} );
					break;
				case 'down':
					res = item.y + rect.height * _swipeForce;
					if (res > rect.y+rect.height) res = rect.y+rect.height;
					tween = TweenMax.to(item, _tweenTime, { y:res, onUpdate:dispatchTweening,onComplete:dropComplete } );
					break;
					
			}
			
		}
		private function swipeFail(e:Event):void
		{
			dropComplete();
		}
		private function dispatchTweening():void
		{
			dispatchEvent(new DragEvent(DragEvent.INNERTION));
		}
		private function dropComplete():void
		{
			trace('drop complete');
			dispatchEvent(new DragEvent(DragEvent.ON_MOVE_COMPLETE));
		}
		override protected function gesEnd(x:int, y:int):void 
		{
			super.gesEnd(x, y);
			dispatchEvent(new DragEvent(DragEvent.ON_DROP));
		}
		
		//PARAMETERS:
		public function get dragRectangle():Rectangle 
		{
			return rect;
		}
		
		
		/**0 - свайп не прокручивает  объект
		 * 1 - свайп бросает объект до противоположного края
		 * 
		 */
		public function get swipeForce():Number 
		{
			return _swipeForce;
		}
		
		public function set swipeForce(value:Number):void 
		{
			_swipeForce = value;
		}
		/**
		 * 1 = 1sec
		 */
		public function get tweenTime():Number 
		{
			return _tweenTime;
		}
		
		public function set tweenTime(value:Number):void 
		{
			_tweenTime = value;
		}
		
		
		
	}

}