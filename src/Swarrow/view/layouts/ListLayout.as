package Swarrow.view.layouts 
{
	import flash.accessibility.Accessibility;
	import flash.display.DisplayObject;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import Swarrow.view.glifs.Glif;
	import Swarrow.view.glifs.GlifEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class ListLayout extends LayoutBase 
	{
		
		public function ListLayout() 
		{
			super();
			trueHeight = true;
		}
		var childUpdateHandlerFlag:Boolean = true;
		override protected function onWidthSet():void 
		{
			var child:DisplayObject;
			
			childUpdateHandlerFlag = false;
			for (var i:int = 0; i < numChildren; i++) 
			{
				child = getChildAt(i);
				if(child is Glif || !ignorNonGlifs)
				child.width = width;
			}
			childUpdateHandlerFlag = true;
			callUpdate();
		}
		override protected function onGlifHeightChange(e:GlifEvent):void 
		{
			//callUpdate(getChildIndex(e.target as DisplayObject));
			if (childUpdateHandlerFlag);
			callUpdate();
		}
		
		override protected function callUpdate(from:int=0):void
		{
			var border:int=width;
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
				
				item.x = offsetX;
				item.y = offsetY;
				offsetY += item.height + verticalInterval;
				
			}
			dispatchHeightChange();
		}
		
	}

}