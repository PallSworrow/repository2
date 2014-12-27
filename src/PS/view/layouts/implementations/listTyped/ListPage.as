package PS.view.layouts.implementations.listTyped 
{
	import PS.view.layouts.interfaces.IlistLayoutItem;
	import flash.display.DisplayObject;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public class ListPage  implements IlistLayoutItem 
	{
		private var _source:IviewElement;
		private var forcedSize:int=0;
		private var _isVertical:Boolean;
		
		public function ListPage(vertical:Boolean) 
		{
			super();
			_isVertical = vertical;
		}
		
	
		/* INTERFACE PS.view.scroller.interfaces.IlistItem */
		
		
		/* INTERFACE PS.view.scroller.interfaces.IlistItem */
		
		public function set vertical(value:Boolean):void 
		{
			if (value != _isVertical)
			{
				item.x = item.y = 0;
			}
			_isVertical = value;
		}
		
		
		public function get vertical():Boolean
		{
			return _isVertical;
		}
		
		/* INTERFACE PS.view.scroller.interfaces.IlistItem */
		
		public function get item():IviewElement 
		{
			return _source;
		}
		
		public function get offset():int 
		{
			if (vertical) return item.y;
			else return item.x;
		}
		
		public function get size():int 
		{
			if (forcedSize != 0) return forcedSize;
			if (vertical) return item.height;
			else return item.width;
		}
		public function set size(value:int):void 
		{
			
			forcedSize = value;
		}
		
		
		//full access
		public function set item(value:IviewElement):void 
		{
			_source = value;
		}
		public function get altOffset():int
		{
			if (!vertical) return item.y;
			else return item.x;
		}
		public function set altOffset(value:int):void
		{
			if (!vertical) 
				item.y = value;
			else
				item.x = value;
		}
		
		public function get altSize():int
		{
			if (forcedSize != 0) return forcedSize;
			if (!vertical) return item.height;
			else return item.width;
		}
		
		
		public function set offset(value:int):void 
		{
			if (vertical) 
			{
				item.y = value;
				//item.x = 0;
			}
			else
			{
				item.x = value;
				//item.y = 0;
			}
		}
		
	}

}