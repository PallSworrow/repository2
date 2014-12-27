package PS.view.layouts.implementations.tagTyped {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.layouts.interfaces.ItagLayout;
	import PS.view.layouts.LayoutBase;
	
	/**
	 * ...
	 * @author 
	 */
	public class SimpleTagLayout extends LayoutBase implements ItagLayout 
	{
		
		public function SimpleTagLayout(rectangle:Rectangle=null) 
		{
			super(rectangle);
			
		}
		
		/* INTERFACE PS.view.layouts.interfaces.ItagLayout */
		private var list:Object = { };
		private var _placeMethod:Function;
		private var _disposeRemovedItems:Boolean = false;
		public function addItem(item:IviewElement, tag:String=null):void 
		{
			if (tag)
			{
				if (list[tag]) removeByTag(tag);
				list[tag] = item;
			}
			if(autoUpdate)
			update();
			addElement(item);
		}
		
		protected function nativePlaceMethod(item:IviewElement, tag:String):void 
		{
			
		}
		override public function update():void 
		{
			var item:IviewElement;
			if (_placeMethod is Function)
			{
				switch(_placeMethod.length)
				{
					case 1:
						_placeMethod(list);
						return;
						break;
					case 2:
						_placeMethod(this, list);
						return;
						break;
				}
			}
			for (var tag:String in list)
			{
				item = list[tag];
				if (_placeMethod is Function) _placeMethod(this,item, tag);
				else nativePlaceMethod(item, tag);
			}
			super.update();
		}
		public function removeItem(item:IviewElement):void 
		{
			var tag:String = getTagOf(item);
			if (tag)
			{
				list[tag] = null;
			}
			if (disposeRemovedItems) item.dispose();
			else item.remove();
		}
		
		public function removeByTag(tag:String):void 
		{
			
			if (list[tag])
			{
				
				if (disposeRemovedItems) list[tag].dispose();
				else list[tag].remove();
				list[tag] = null;
				delete list[tag];
			}
		}
		
		public function getItem(tag:String):IviewElement 
		{
			return list[tag] as IviewElement;
		}
		
		public function getTagOf(item:IviewElement):String 
		{
			for (var tag:String in list)
			{
				if (list[tag] == item) return tag;
			}
			return null;
		}
		
	
		override public function clear():void 
		{
			//removeChildren();
			var child:DisplayObject;
			for (var i:int = numChildren -1; i >=0 ; i--) 
			{
				child = getChildAt(i);
				if (child is IviewElement)
				{
					if (disposeRemovedItems) (child as IviewElement).dispose();
					else (child as IviewElement).remove();
				}
				else
				{
					removeChild(child);
				}
			}
			list = { };
			super.clear();
		}
		
		override public function dispose():void 
		{
			super.dispose();
			list = null;
		}
		
		/* INTERFACE PS.view.layouts.interfaces.ItagLayout */
		
		public function get disposeRemovedItems():Boolean 
		{
			return _disposeRemovedItems;
		}
		
		public function set disposeRemovedItems(value:Boolean):void 
		{
			_disposeRemovedItems = value;
		}
		
		public function set placeMethod(value:Function):void 
		{
			_placeMethod = value;
		}
		override public function get width():Number 
		{
			if (fakeSizeEnabled) return fakeWidth;
			return super.width;
		}
		override public function get height():Number 
		{
			if (fakeSizeEnabled) return fakeHeight;
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			if (fakeSizeEnabled) fakeHeight = value;
			else
			super.height = value;
		}
		override public function set width(value:Number):void 
		{
			if (fakeSizeEnabled) fakeWidth = value;
			else
			super.width = value;
		}
		
	}

}