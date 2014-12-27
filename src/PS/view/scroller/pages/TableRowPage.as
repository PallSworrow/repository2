package PS.view.scroller.pages 
{
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import PS.model.interfaces.IviewElement;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.layouts.interfaces.IlistLayout;
	import PS.view.scroller.advanced.interfaces.Ipage;
	import PS.view.layouts.interfaces.IlistLayoutItem;
	
	/**
	 * ...
	 * @author 
	 */
	public class TableRowPage extends SimpleListLayout implements Ipage 
	{
		private var _needEarlyLoad:Boolean = true;
		private var _isLoaded:Boolean = false;
		private var _isEnabled:Boolean = false;
		
		public function TableRowPage() 
		{
			super();
			
		}
		override public function addItem(item:IviewElement, forceSize:int = -1):void 
		{
			super.addItem(item, forceSize);
		}
		override public function addItemTo(item:IviewElement, index:int, forceSize:int = -1):void 
		{
			super.addItemTo(item, index, forceSize);
		}
		/* INTERFACE PS.view.scroller.advanced.interfaces.Ipage */
		
		public function init(data:Object):void 
		{
			
		}
		
		public function kill():void 
		{
			
		}
		override public function update():void 
		{
			super.update();
		}
		public function load():void 
		{
			if (isLoaded) return;
			_isLoaded = true;
			for (var i:int = length - 1; i >= 0; i--)
			{
				if(!(getItem(i) as Ipage).isLoaded)(getItem(i) as Ipage).load();
			}
		}
		override public function clear():void 
		{
			if (!isLoaded) return;
			_isLoaded = false;
			for (var i:int = length - 1; i >= 0; i--)
			{
				if((getItem(i) as Ipage).isLoaded)(getItem(i) as Ipage).clear();
			}
		}
		public function enable():void 
		{
			if (isEnabled) return;
			_isEnabled = true;
			for (var i:int = length - 1; i >= 0; i--)
			{
				if(!(getItem(i) as Ipage).isEnabled)(getItem(i) as Ipage).enable();
			}
		}
		
		public function disable():void 
		{
			if (!isEnabled) return;
			_isEnabled = false;
			for (var i:int = length - 1; i >= 0; i--)
			{
				if((getItem(i) as Ipage).isEnabled)(getItem(i) as Ipage).disable();
			}
		}
		
		public function get needEarlyLoad():Boolean 
		{
			return _needEarlyLoad;
		}
		
		public function get isLoaded():Boolean 
		{
			return _isLoaded;
		}
		
		public function get isEnabled():Boolean 
		{
			return _isEnabled;
		}
		
		public function isTapped(globalPoint:Point):Boolean 
		{
			return false;
		}
		
		
	}

}