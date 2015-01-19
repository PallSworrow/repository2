package Swarrow.view.layouts 
{
	import flash.display.DisplayObject;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import Swarrow.view.glifs.Glif;
	import Swarrow.view.glifs.GlifEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class LayoutBase extends Glif 
	{
		
		public var autoUpdate:Boolean = true;
		public var ignorNonGlifs:Boolean = true;
		public function LayoutBase() 
		{
			super();
			
		}
		
		
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			child.addEventListener(GlifEvent.WIDTH_CHANGE, onGlifWidthChange);
			child.addEventListener(GlifEvent.HEIGHT_CHANGE, onGlifHeightChange);
			var res:DisplayObject = super.addChild(child);
			if(autoUpdate)
			callUpdate(numChildren - 1);
			return res;
		}
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			
			child.addEventListener(GlifEvent.WIDTH_CHANGE, onGlifWidthChange);
			child.addEventListener(GlifEvent.HEIGHT_CHANGE, onGlifHeightChange);
			var i:int = getChildIndex(child);
			var res:DisplayObject = super.addChildAt(child, index);
			if(autoUpdate)
			{
				if (i < index && i>=0)
				callUpdate(i);
				else 
				callUpdate(index);
			}
			
			return res;
		}
		override public function addElement(element:IviewElement):void 
		{
			super.addElement(element);
			
			element.addEventListener(GlifEvent.WIDTH_CHANGE, onGlifWidthChange);
			element.addEventListener(GlifEvent.HEIGHT_CHANGE, onGlifHeightChange);
			if(autoUpdate)
			callUpdate(numChildren - 1);
		}
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			child.removeEventListener(GlifEvent.WIDTH_CHANGE, onGlifWidthChange);
			child.removeEventListener(GlifEvent.HEIGHT_CHANGE, onGlifHeightChange);
			var index:int = getChildIndex(child);
			var res:DisplayObject = super.removeChild(child);
			if(autoUpdate)
			callUpdate(index);
			
			return res;
		}
		
		override public function removeChildAt(index:int):DisplayObject 
		{
			var res:DisplayObject = super.removeChildAt(index);
			
			res.removeEventListener(GlifEvent.WIDTH_CHANGE, onGlifWidthChange);
			res.removeEventListener(GlifEvent.HEIGHT_CHANGE, onGlifHeightChange);
			if(autoUpdate)
			callUpdate(index);
			return res;
		}
		override public function removeElement(element:IviewElement):void 
		{
			
			element.removeEventListener(GlifEvent.WIDTH_CHANGE, onGlifWidthChange);
			element.removeEventListener(GlifEvent.HEIGHT_CHANGE, onGlifHeightChange);
			super.removeElement(element);
			if(autoUpdate)
			callUpdate(0);
		}
		public function clear():void
		{
			for (var i:int = 0; i < numChildren; i++) 
			{
				removeChildAt(i);
			}
		}
		
		
		protected function callUpdate(index:int=0):void 
		{
			
		}
		public function update():void
		{
			callUpdate(0);
		}
		
		protected function onGlifWidthChange(e:GlifEvent):void
		{
			
		}
		protected function onGlifHeightChange(e:GlifEvent):void
		{
			
		}
		
	}

}