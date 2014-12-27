package PS.view.layouts {
	import com.greensock.plugins.EndVectorPlugin;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import PS.model.BaseSprite;
	import PS.view.layouts.interfaces.Ilayout;
	/**
	 * ...
	 * @author 
	 */
	public class LayoutBase extends BaseSprite implements Ilayout 
	{
		private var rect:Rectangle = new Rectangle();
		private var _autoUpdate:Boolean = true;
		private var _disposeChildrenOnRemove:Boolean = false;
		private var _fakeSizeEnabled:Boolean = false;
		private var _fakeWidth:int=0;
		private var _fakeHeight:int=0;
		public function LayoutBase(rectangle:Rectangle=null) 
		{
			if (rectangle) setRectangle(rectangle);
		}
		
		/* INTERFACE view.placers.interfaces.Iplacer */
		
		public function setRectangle(rectangle :Rectangle):void 
		{
			rect = rectangle;
			if (autoUpdate) update();
		}
		
		public function get borderLeft():int 
		{
			return rect.x;
		}
		
		public function get borderRight():int 
		{
			return rect.x+rect.width;
		}
		
		public function get borderUpper():int 
		{
			return rect.y;
		}
		
		public function get borderLower():int 
		{
			return rect.y+rect.height;
		}
		
		public function get borderWidth():int 
		{
			return rect.width;
		}
		
		public function get borderHeight():int 
		{
			return rect.height;
		}
		
		//SETTERS:
		public function set borderLeft(value:int):void 
		{
			rect.x = value;
		}
		
		public function set borderRight(value:int):void 
		{
			
			rect.width = value- rect.x;
		}
		
		public function set borderUpper(value:int):void 
		{
			rect.y = value;
		}
		
		public function set borderLower(value:int):void 
		{
			rect.height = value - rect.y;
		}
		
		public function set borderWidth(value:int):void 
		{
			rect.width = value;
		}
		
		public function set borderHeight(value:int):void 
		{
			rect.height = value;
		}
		//
		public function clear():void 
		{
			
		}
		override public function dispose():void 
		{
			clear();
			super.dispose();
		}
		
		/* INTERFACE PS.view.layouts.interfaces.Ilayout */
		
		public function get autoUpdate():Boolean 
		{
			return _autoUpdate;
		}
		
		public function set autoUpdate(value:Boolean):void 
		{
			_autoUpdate = value;
		}
		
		public function get disposeChildrenOnRemove():Boolean 
		{
			return _disposeChildrenOnRemove;
		}
		
		public function set disposeChildrenOnRemove(value:Boolean):void 
		{
			_disposeChildrenOnRemove = value;
		}
		
		public function update():void 
		{
			dispatchEvent(new LayoutEvent(LayoutEvent.UPDATE));
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		
		
		/* INTERFACE PS.view.layouts.interfaces.Ilayout */
		
		public function set fakeWidth(value:int):void 
		{
			_fakeWidth = value;
		}
		
		public function get fakeWidth():int 
		{
			return _fakeWidth;
		}
		
		public function set fakeHeight(value:int):void 
		{
			_fakeHeight = value;
		}
		
		public function get fakeHeight():int 
		{
			return _fakeHeight;
		}
		
		
		public function set fakeSizeEnabled(value:Boolean):void 
		{
			_fakeSizeEnabled = value;
		}
		
		public function get fakeSizeEnabled():Boolean 
		{
			return _fakeSizeEnabled;
		}
		
	}

}