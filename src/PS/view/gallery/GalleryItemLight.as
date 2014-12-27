package PS.view.gallery 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.gallery.GalleryItemBase;
	import PS.view.gallery.interfaces.IgalleryItem;
	
	/**
	 * ...
	 * @author 
	 */
	public class GalleryItemLight implements IgalleryItem 
	{
		private var inst:BaseSprite;
		private var box:DisplayObjectContainer;
		protected var params:Object;
		//Gallery vars:
		private var _needEarlyLoad:Boolean = true;
		private var _isLoaded:Boolean = false;
		private var _isEnabled:Boolean = false;
		//view element vars:
		private var _x:int;
		private var _y:int;
		private var _rotation:int;
		private var _width:int;
		private var _height:int;
		private var _name:String;
		
		public function GalleryItemLight(w:int, h:int) 
		{
			_width = w;
			_height = h;
			
		}
		//protected:
		protected function addChild(child:DisplayObject):void
		{
			if (inst) inst.addChild(child);
			else throw new Error(this + ' не может добавлять объекты до вызова команды load()');
		}
		protected function removeChild(child:DisplayObject):void
		{
			if (child.parent) child.parent.removeChild(child);
		}
		protected function addElement(element:IviewElement):void
		{
			if (inst) element.addTo(inst);
			else throw new Error(this + ' не может добавлять объекты до вызова команды load()');
		}
		protected function removeElement(element:IviewElement):void
		{
			element.remove();
		}
		/* INTERFACE PS.view.gallery.interfaces.IgalleryItem */
		//GALLERY METHODS:
		//getters^
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
		
		//INIT|KILL:
		public function init(data:Object):void 
		{
			params = data;
		}
		public function kill():void 
		{
			clear();
			params = null;
		}
		
		//LOAD|CLEAR:
		public function load():void 
		{
			if (!inst) 
			{
				inst = new BaseSprite();
				inst.x = _x;
				inst.y = _y;
				if (box) inst.addTo(box);
			}
			_isLoaded = true;
		}
		public function clear():void 
		{
			if (isEnabled) disable();
			if (inst) 
			{
				inst.dispose();
				inst = null;
			}
			_isLoaded = false;
		}
		
		//ENABLE|DISABLE:
		public function enable():void 
		{
			if (!isLoaded) load();
			_isEnabled = true;
		}
		public function disable():void 
		{
			
			_isEnabled = false;
		}
		
		
		
		//VIEW ELEMENT EMULATION:
		public function get x():Number 
		{
			return _x;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function get rotation():Number 
		{
			return _rotation;
		}
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function get height():Number 
		{
			return _height;
		}
		
		public function set width(value:Number):void 
		{
			//_width = value;
		}
		
		public function set height(value:Number):void 
		{
			//_height = value;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
			if (inst) inst.x = value;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
			if (inst) inst.y = value;
		}
		
		public function set rotation(value:Number):void 
		{
			//_rotation = value;
		}
		
		public function addTo(container:DisplayObjectContainer):void 
		{
			box = container;
			if (inst) inst.addTo(box);
		}
		
		public function remove():void 
		{
			if (inst) inst.remove();
			box = null;
		}
		
		public function dispose():void 
		{
			kill();
			remove();
		}
		
		/* INTERFACE PS.view.gallery.interfaces.IgalleryItem */
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle 
		{
			return null;
		}
	}

}