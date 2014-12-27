package PS.view.layouts.implementations.listTyped {
	import adobe.utils.CustomActions;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.layouts.interfaces.IlistLayout;
	import PS.view.layouts.interfaces.IlistLayoutItem;
	import PS.view.layouts.LayoutBase;
	
	/**
	 * Сейчас выбран менее оптимизированный, но более удобный для расширения подход - 
	 * Положения и значения параметров listItem-ов определяется в функции update и только в ней. 
	 * она олжна быть вызвана после каждого действия
	 * 
	 * Другой подход избегает обхода всего списка там где это возможно, 
	 * но тогда алгоритм размещения объектов дублируется и становится карйне неудобным для расширений
	 * ...
	 * @author 
	 */
	public class SimpleListLayout extends LayoutBase implements IlistLayout 
	{
		//main vars:
		private var _vertical:Boolean = true;
		private var _pagesInterval:int=0;
		private var _size:int;
		
		
		
		protected var W:int;
		protected var H:int;
		protected var list:Vector.<ListPage> = new Vector.<ListPage>;
		public function SimpleListLayout() 
		{
			super();
		}
		
		
		/* INTERFACE PS.view.layouts.interfaces.IlistLayout */
		//METHODS:
		public function addItem(item:IviewElement, forceSize:int = -1):void 
		{
			addItemTo(item, length, forceSize);
		}
		public function addItemTo(item:IviewElement, index:int, forceSize:int = -1):void 
		{
			if (index < 0) index = 0;
			//if already added:
			var curIndex:int = getIndexOf(item);
			if (curIndex >= 0) removeByIndex(curIndex);
			
			
			var obj:ListPage = new ListPage(vertical);
			obj.item = item;
			if (forceSize >0) obj.size = forceSize;
			
			
			if(index < length) list.splice(index, 0, obj);
			else list.push(obj);
			
			item.addTo(this);
			if(autoUpdate) update();
		}
		public function removeItem(item:IviewElement):void 
		{
			var index:int;
			for (var i:int = list.length - 1; i >= 0; i--)
			{
				if (list[i].item == item) 
				{
					removeByIndex(i);
					break;
				}
			}
		}
		public function removeByIndex(index:int):void 
		{
			if (index <0 || index >= length) return;
			var item:ListPage = list[index];
			/*var step:int = item.size + pagesInterval;
			item.item.remove();
			item = null;
			list.splice(i, 1);
			for (var i:int = index; i < list.length; i++)
			{
				list[i].offset -= step;
			}*/
			if (disposeChildrenOnRemove)
			item.item.dispose();
			else
			item.item.remove();
			
			item = null;
			list.splice(index, 1);
			if(autoUpdate) update();
		}
		override public function clear():void 
		{
			var item:IviewElement;
			for (var i:int = list.length - 1; i >= 0; i--)
			{
				item = list[i].item;
				
				if (disposeChildrenOnRemove)
				item.dispose();
				else
				item.remove();
				
				list.splice(i, 1);
			}
			
			super.clear();
		}
		override public function update():void 
		{
			size = 0;
			var L:int = list.length;
			var item:ListPage;
			//trace(this + 'UPDATE varticl:'+vertical);
			for (var i:int = 0; i < L; i++)
			{
				item = list[i];
				item.vertical = vertical;
				if (i > 0) item.offset = size + _pagesInterval;
				else item.offset = 0;
		
				size = item.offset+item.size;
				
				//trace(item.item.x);
			}
			super.update();
		}
		override public function dispose():void 
		{
			super.dispose();
		}
		//SETTERS:
		public function set vertical(value:Boolean):void 
		{
			if (value == _vertical) return
		
			
			_vertical = value;
			if(autoUpdate) update();
		}
		public function set size(value:int):void 
		{
			if (vertical)
			{
				H = value;
				W = borderWidth;
			}
			else 
			{
				H = borderHeight;
				W = value;
			}
		}
		public function set pagesInterval(value:int):void 
		{
			if (value == _pagesInterval) return;
			if(autoUpdate) update();
			_pagesInterval = value;
		}
		
		//GETTERS:
		public function getListItem(index:int):IlistLayoutItem 
		{
			return list[index];
		}
		public function getItem(index:int):IviewElement 
		{
			return list[index].item;
		}
		public function getIndexOf(item:IviewElement):int
		{
			for (var i:int = 0; i < list.length; i++) 
			{
				if (getItem(i) == item) return i;
			}
			return -1;
		}
		/* INTERFACE PS.view.layouts.interfaces.IlistLayout */
		
		public function get instance():DisplayObject 
		{
			return this;
		}
		public function get length():int 
		{
			return list.length;
		}
		public function get vertical():Boolean 
		{
			return _vertical;
		}
		public function get size():int 
		{
			if (vertical) return H;
			else return W;
		}
		public function get pagesInterval():int 
		{
			return _pagesInterval;
		}
		
		
		//OVERRRIDES:
		override public function get width():Number 
		{
			if (!vertical) return W;
			else 
			{
				if (fakeSizeEnabled) return fakeWidth;
				return super.width;
			}
		}
		
		override public function set width(value:Number):void 
		{
			//super.width = value;
		}
		override public function get height():Number 
		{
			if (vertical) return H;
			else
			{
				if (fakeSizeEnabled) return fakeHeight;
				return super.height;
			}
		}
		
		override public function set height(value:Number):void 
		{
			//super.height = value;
		}
		/* INTERFACE PS.view.layouts.interfaces.IlistLayout */
		
		
		/* INTERFACE PS.view.layouts.interfaces.IlistLayout */
		
	
		
		
	}

}