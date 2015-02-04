package Swarrow.view.layouts 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import Swarrow.tools.dataObservers.IntegerObserver;
	import Swarrow.view.glifs.GlifEvent;
	/**
	 * ...
	 * @author pall
	 */
	public class LineLayout extends LayoutBase
	{
		
		public function LineLayout() 
		{
			super();
			trueHeight = true;
		}
		
		override protected function callUpdate(from:int=0):void
		{
			trace(this, ' --- update: ' + from + ' ---- ');
			from = 0;
			var border:int= width;
			var item:DisplayObject;
			var horizontalInterval:int = intervalX;
			var verticalInterval:int = intervalY;
			
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
				
				if (border>0 && item.width < border && item.width+offsetX > border)
				{
					offsetY += lineHeight + verticalInterval;
					
					offsetX = 0;
					lineHeight = 0;
				}
				item.x = offsetX;
				item.y = offsetY;
				offsetX += item.width + horizontalInterval;
			}
			
			dispatchHeightChange();
		}
		override protected function onGlifHeightChange(e:GlifEvent):void 
		{
			callUpdate(getChildIndex(e.target as DisplayObject));
		}
		override protected function onGlifWidthChange(e:GlifEvent):void 
		{
			callUpdate(getChildIndex(e.target as DisplayObject));
		}
		override protected function onWidthSet():void 
		{
			callUpdate();
		}
	}

}