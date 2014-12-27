package PS.view.scroller 
{
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import PS.controller.Controller;
	import PS.controller.DragController;
	import PS.controller.events.DragEvent;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.scroller.events.ScrollerEvent;
	import PS.view.scroller.interfaces.Iscroller;
	/**
	 * ...
	 * @author 
	 */
	public class ScrollBar extends BaseSprite
	{
		private var _isVertical:Boolean = new Boolean();
		private var ind:InteractiveObject;
		private var bg:DisplayObject;
		private var ctrl:DragController;
	
		private var _innerOffset:int
		
		public function ScrollBar(length:int, background:DisplayObject, indicator:InteractiveObject, vertical:Boolean = true ) 
		{
			super();
			bg = background;
			_isVertical = vertical;
			if (vertical) bg.height = length;
			else bg.width = length;
			ind = indicator;
			ind.x = (bg.width-ind.width) / 2;
			ind.y = (bg.height-ind.height) / 2;
			var rect:Rectangle;
			if (vertical)
			rect = new Rectangle(ind.x, 0, 0, getMaxOffset());
			else
			rect = new Rectangle(0, ind.y, getMaxOffset() , 0);
			
			ctrl = new DragController(rect);
			ctrl.item = ind;
			ctrl.addEventListener(DragEvent.ON_DRAG, onMove);
			
			
			
			addChild(bg);
			addChild(ind);
			innerOffset = 0;
		}
		override public function dispose():void 
		{
			super.dispose();
		}
		
		//ENGINE:
		private function get innerOffset():int 
		{
			if(isVertical)
			return ind.y;
			else
			return ind.x;
		}
		
		private function set innerOffset(value:int):void 
		{
			if (value < 0) value = 0;
			if (value > getMaxOffset()) value = getMaxOffset();
			if(isVertical)
			ind.y = value;
			else
			ind.x = value;
			
			onMove();
		}
		private function innerScroll(offset:int,duration:Number=0):void
		{
			if (offset < 0) offset = 0;
			if (offset > getMaxOffset()) offset = getMaxOffset();
			ctrl.drop();
			
			if (isVertical) TweenMax.to(ind, duration, { y:offset, onUpdate:onMove } );
			else			TweenMax.to(ind, duration, { x:offset, onUpdate:onMove } );
		}
		private function onMove(e:Event=null):void
		{
			dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL));
		}
		private function getIndicatorBoxSize():int
		{
			if (isVertical)
			return bg.height;
			else
			return bg.width;
		}
		public function setIndicatorBoxSize(value:int):void
		{
			var prop:Number = proportion;
			var per:Number = percent;
			if (isVertical)
			bg.height = value;
			else
			bg.width = value;
			
			proportion = prop;
			percent = percent;
			
		}
		private function get indicatorSize():int
		{
			if (isVertical)
			return ind.height;
			else
			return ind.width;
		}
		private function set indicatorSize(value:int):void
		{
			if (isVertical)
			{
				ind.height = value;
				ctrl.dragRectangle.height = getMaxOffset();
			}
			else
			{
				ind.width = value;
				ctrl.dragRectangle.width = getMaxOffset();
			}
			
		}
		//PUBLIC
		public function scroll(percent:Number):void 
		{
			innerScroll(percent * getMaxOffset(),0);
		}
		
		public function scroll2(offset:int):void 
		{
			innerScroll(offset);
		}
		
		public function get percent():Number 
		{
			return offset/getMaxOffset();
		}
		
		public function get offset():int 
		{
			return innerOffset;
		}
		
		public function set percent(value:Number):void 
		{
			offset = value*getMaxOffset();
		}
		
		public function set offset(value:int):void 
		{
			innerOffset = value;
		}
		
	
		public function get proportion():Number 
		{
			return indicatorSize / getIndicatorBoxSize();
			
		}
		public function set proportion(value:Number):void 
		{
			if (value < 0.2) value = 0.2
			if (value > 1) value = 1;
			
			indicatorSize = getIndicatorBoxSize() * value;
		}
		
		public function getMaxOffset():int 
		{
			return getIndicatorBoxSize() - indicatorSize;
		}
		
	
		
		public function get isVertical():Boolean 
		{
			return _isVertical;
		}
		
		
		
	}

}