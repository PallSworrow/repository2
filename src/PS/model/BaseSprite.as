package PS.model {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import PS.model.interfaces.Idisplayable;
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public class BaseSprite extends Sprite implements IviewElement
	{
		public function BaseSprite() 
		{
			super();
			
		}
		
		public function addElement(element:IviewElement):void
		{
			element.addTo(this);
		}
		public function removeElement(element:IviewElement):void
		{
			element.remove();
		}
		/* INTERFACE PS_starling.model.interfaces.IdisplayElement */
		
		public function addTo(container:DisplayObjectContainer):void 
		{
			container.addChild(this);
		}
		
		public function remove():void 
		{
			if (parent) parent.removeChild(this);
		}
		public function dispose():void 
		{
			
			var elt:DisplayObject
			for (var i:int = 0; i < numChildren; i++) 
			{
				elt = getChildAt(i);
				removeChild(elt);
				if (elt is Idisplayable) (elt as Idisplayable).dispose();
			}
			remove();
		}
		
		
		
		
	}

}