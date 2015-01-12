package Swarrow.view.layouts 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import Swarrow.tools.dataObservers.IntegerObserver;
	/**
	 * ...
	 * @author pall
	 */
	public class LineLayout extends BaseSprite
	{
		private var _widthObserver:IntegerObserver;
		public function LineLayout() 
		{
			_widthObserver = new IntegerObserver();
		}
		override public function get width():Number 
		{
			return widthObserver.currentValue;
		}
		
		override public function set width(value:Number):void 
		{
			widthObserver.currentValue = value;
			
		}
		
		public function get widthObserver():Object 
		{
			return _widthObserver;
		}
		
		public function set widthObserver(value:Object):void 
		{
			if (value is Number) _widthObserver.currentValue = int(value);
			else if (value is IntegerObserver)
			{
				_widthObserver.removeListener(onObserverUpdate);
				_widthObserver = value as IntegerObserver;
				_widthObserver.addListener(onObserverUpdate);
			}
			
		}
		
		private function onObserverUpdate(e:Event):void 
		{
			callUpdate(0);
		}
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			var res:DisplayObject = super.addChild(child);
			callUpdate(numChildren - 1);
			return res;
		}
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			var i:int = getChildIndex(child);
			var res:DisplayObject = super.addChildAt(child, index);
			if (i < index && i>=0)
			callUpdate(i);
			else 
			callUpdate(index);
			
			return res;
		}
		override public function addElement(element:IviewElement):void 
		{
			super.addElement(element);
			callUpdate(numChildren - 1);
		}
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			var index:int = getChildIndex(child);
			var res:DisplayObject = super.removeChild(child);
			callUpdate(index);
			
			return res;
		}
		override public function removeChildAt(index:int):DisplayObject 
		{
			var res:DisplayObject = super.removeChildAt(index);
			callUpdate(index);
			return res;
		}
		override public function removeElement(element:IviewElement):void 
		{
			super.removeElement(element);
			callUpdate(0);
		}
		private function callUpdate(from:int=0):void
		{
			var border:int= widthObserver.currentValue;
			var item:DisplayObject;
			var horizontalInterval:int = 0;
			var verticalInterval:int = 0;
			
			var offsetX:int = 0;
			var offsetY:int = 0;
			var lineHeight:int = 0;
			
			var prev:DisplayObject;
			try{prev = getChildAt(from - 1);}catch(e:Error){}
			if (prev)
			{
				offsetX = prev.x;
				offsetY = prev.y;
			}
			
			for (var i:int = from; i < numChildren ; i++) 
			{
				item = getChildAt(i);
				if (lineHeight < item.height) lineHeight = item.height;
				if (border == 0)
				{
					item.x = offsetX;
					item.y = offsetY;
					offsetY += item.height + verticalInterval;
					continue;
				}
				
				if (border>0 && item.width < border && item.width+offsetX > border)
				{
					lineHeight = 0;
					offsetX = 0;
					offsetY += lineHeight + horizontalInterval;
				}
				item.x = offsetX;
				item.y = offsetY;
				offsetX += item.width + verticalInterval;
			}
			
		}
		public function update():void
		{
			callUpdate(0);
		}
	}

}