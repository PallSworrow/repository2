package PS.view.gallery 
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import PS.constants.Direction;
	import PS.controller.events.ControllerEvent;
	import PS.controller.SimpleController;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.button.ButtonPhaze;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.button.PsButton;
	import PS.view.factories.interfaces.gallery.IgalleryItemFactory;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.factories.interfaces.IlistScrollerFactory;
	import PS.view.gallery.events.GalleryEvent;
	import PS.view.gallery.interfaces.Igallery;
	import PS.view.gallery.interfaces.IgalleryItem;
	import PS.view.layouts.implementations.tagTyped.SimpleTagLayout;
	import PS.view.scroller.events.ListEvent;
	import PS.view.scroller.extensions.ListScroller;
	import PS.view.scroller.ListScroller;
	
	/**
	 * ...
	 * @author 
	 */
	public class GalleryBase extends SimpleTagLayout implements Igallery 
	{
		protected static const LIST_OBJECT:String = 'listobject';
		protected static const INC_ARROW:String = 'incArrow';
		protected static const DEC_ARROW:String = 'decArrow';
		
		
		private var sc:ListScroller;
		private var dataProvider:Array = [];
		private var isVertical:Boolean;
		
		private var btn_next:Ibtn;
		private var btn_prev:Ibtn;
		
		protected var ctrl:SimpleController;
		//public vars:
		public var scrollDuration:Number = 0.6;
		//Верхняяя и нижняя граница предвариательной загрузки.
		protected var stackSize_forLowerIndexSide:int = 1;
		protected var stackSize_forHigherIndexSide:int = 1;
		
		private var _itemFactory:IgalleryItemFactory;
		private var _buttonFactory:IbuttonFactory;
		
		private var _isRendered:Boolean = false;
		
		public function GalleryBase(w:int,h:int,vertical:Boolean= false, scrollerProvider:IlistScrollerFactory=null) 
		{
			ctrl = new SimpleController();
			ctrl.item = this;
			isVertical = vertical;
			if (scrollerProvider) sc = scrollerProvider.createScroller(w, h, vertical);
			else sc = createScroller(w,h);
			sc.vertical = vertical;
			sc.updateIndexBeforeSwipe = false;
			addItem(sc, GalleryElementTag.LIST_SCROLLER);
			sc.addEventListener(ListEvent.PAGE_SHOWN, sc_pageShown);
			sc.swipeForce = 0;
			
			createDecArrow();
			createIncArrow();
			ctrl.addEventListener(ControllerEvent.ON_TAP, ctrl_onTap);
		}
		override public function dispose():void 
		{
			ctrl.enabled = false;
			ctrl = null;
			btn_next.dispose();
			btn_next = null;
			btn_prev.dispose();
			btn_prev = null;
			sc.dispose();
			super.dispose();
		}
		//FACTORIES:
		override protected function nativePlaceMethod(item:IviewElement, tag:String):void 
		{
			trace('native placeMethod');
		}
		protected function createScroller(w:int,h:int):ListScroller
		{
			return new ListScroller(w,h);
		}
		protected function createGalleryItem():IgalleryItem
		{
			if (itemFactory) return itemFactory.createItem();
			else return new GalleryItemBase();
			
		}
		private function createDecArrow():void
		{
			if (btn_prev)
			{
				ctrl.removeTrigger('decArrow');
				removeItem(btn_prev);
				btn_prev.dispose();
			}
			if (buttonFactory)
			{
				btn_prev = buttonFactory.createButton(Direction.BACK);
				addItem(btn_prev, GalleryElementTag.DEC_ARROW);
				ctrl.addElementTrigger(btn_prev, btnTap, 'prev','decArrow');
			}
			else  btn_prev = new PsButton();
			
		}
		private function createIncArrow():void
		{
			if (btn_next)
			{
				ctrl.removeTrigger('incArrow');
				removeItem(btn_next);
				btn_next.dispose();
			}
			if (buttonFactory)
			{
				btn_next = buttonFactory.createButton(Direction.NEXT);
				addItem(btn_next, GalleryElementTag.INC_ARROW);
				ctrl.addElementTrigger(btn_next, btnTap, 'next','incArrow');
			}
			else  btn_next = new PsButton();
		}
		//EVENTS:
		private function btnTap(dir:String):void 
		{
			trace('BTN HANDLER:' + dir);
			trace('list length: ' + sc.numPages);
			if (dir == 'next')
				sc.stepNext();
			else sc.stepBack();
			
		}
		private function ctrl_onTap(e:ControllerEvent):void 
		{
			trace(this + 'tap: '+ctrl.targTrigId);
			
			if (ctrl.targetTrigger == null)
			{
				var empty:Boolean = true
				var item:IgalleryItem;
				for (var i:int = sc.numPages - 1; i >= 0; i--)
				{
					item = sc.getItem(i).item as IgalleryItem;
					trace('item[' + i + '] enbled: ' + item.isEnabled);
					if(item.isEnabled) empty = !item.isTapped(ctrl.startPoint);
				}
				if (empty) dispatchEvent(new GalleryEvent(GalleryEvent.EMPTY_TAP));
				else dispatchEvent(new GalleryEvent(GalleryEvent.ITEM_TAP));
			}
			
			
		}
		private function sc_pageShown(e:ListEvent):void 
		{
			checkItems(e.pageIndex);
			
			
		}
		
		
		
		//ENGNINE:
		private function checkItems(current:int):void
		{
			//trace('CHECK');
			var galleryItem:IgalleryItem;
			var listItem:IlistItem;
			for (var i:int = sc.numPages - 1; i >= 0; i--)
			{
				listItem = sc.getItem(i);
				galleryItem = (listItem.item as IgalleryItem);
				
				//управление загрузкой/очисткой элементов
				if (i == current)
				{
					if (!galleryItem.isLoaded) galleryItem.load();
				}
				else if (i <= current + stackSize_forHigherIndexSide && i>= current - stackSize_forLowerIndexSide
				&& galleryItem.needEarlyLoad)
				{
					//Если индекс элемента укладывается в отведенною для предвариательной загрузки облать(stack = forLowerIndex+1+forHigherIndex)
					//И если элемент требует предварительной загрузки - вызываем load();
					if (!galleryItem.isLoaded) galleryItem.load();
					
				}
				else
				{
					if(galleryItem.isLoaded) galleryItem.clear();
				}
				//Если есть элементы попавшие в "окно" рендера - активируем их:
				//trace('item upper: ' + (listItem.size + listItem.offset) + ', offset: ' + listItem.offset);
				//trace('sc upper: ' + (sc.size + sc.offset) + ', offset: ' + sc.offset);
				if (listItem.offset < sc.offset+sc.size && listItem.offset+listItem.size > sc.offset)
				{
					if(!galleryItem.isEnabled) galleryItem.enable();
				}
				else 
				{
					
					if(galleryItem.isEnabled) galleryItem.disable();//в противном случае - останавливаем
				}
				
				
			}
			//Проверяем стрелки(активные/неактивные)
			checkArrows();
		}
		private function checkArrows():void
		{
			if (sc.currentPage == 0) btn_prev.setPhaze(ButtonPhaze.DEFAULT);
			else btn_prev.setPhaze(ButtonPhaze.ACTIVE);
			
			if (sc.currentPage == sc.numPages-1) btn_next.setPhaze(ButtonPhaze.DEFAULT);
			else btn_next.setPhaze(ButtonPhaze.ACTIVE);
		}
		
		
		
		
		/* INTERFACE PS.view.gallery.interfaces.Igallery */
		
		public function addItemData(data:Object, order:int = -1):void 
		{
			if (order <0) dataProvider.push(data);
			else dataProvider[order] = data;
		}
		
		public function removeItemData(index:int):void 
		{
			dataProvider.splice(index, 1);
		}
		public function setData(value:Array):void
		{
			if (value == null) dataProvider = [];
			else dataProvider = value;
		}
		
		
		public function render():void 
		{
			sc.clear();//!! вызывать перерасчет списка только в случае крайней необходимости(он полностью удаляет все объекты и составляет список заново)
			var newDP:Array = [];
			var item:IgalleryItem;
			trace('DATAPROVIDER length: ' + dataProvider.length);
			for (var i:int = 0; i < dataProvider.length; i++)
			{
				if (dataProvider[i])
				{
					newDP.push(dataProvider[i]);
					
					item = createGalleryItem();
					item.init(dataProvider[i]);
					if(isVertical) sc.addItem(item, sc.height);
					else sc.addItem(item, sc.width);
				}
			}
			dataProvider = newDP;
			checkItems(0);
			_isRendered = true;
			trace('numpages: ' + sc.numPages);
		}
		override public function clear():void
		{
			_isRendered = false;
			for (var i:int = sc.numPages - 1; i >= 0; i--)
			{
				(sc.getItem(i).item as IgalleryItem).dispose();
			}
			sc.clear();
		}
		public function fullClear():void
		{
			clear();
			dataProvider = [];
		}
		
		// PUBLIC CONTROLL:
		public function scrollTo(pageIndex:int):void 
		{
			sc.scrollToPage(pageIndex,scrollDuration);
		}
		public function next():void 
		{
			sc.stepNext();
		}
		
		public function prev():void 
		{
			sc.stepBack();
		}
		
		public function set pageIndex(value:int):void 
		{
			sc.currentPage = value;
		}
		
		public function get pageIndex():int 
		{
			return sc.currentPage;
		}
		
		public function get numPages():int 
		{
			return sc.numPages;
		}
		
		
		//BASE OVERRIDES:
		override public function get width():Number 
		{
			return sc.width;
		}
		
		override public function set width(value:Number):void 
		{
			//super.width = value;
		}
		override public function get height():Number 
		{
			return sc.height;
		}
		
		override public function set height(value:Number):void 
		{
			//super.height = value;
		}
		
		public function get itemFactory():IgalleryItemFactory
		{
			return _itemFactory;
		}
		
		public function get buttonFactory():IbuttonFactory 
		{
			return _buttonFactory;
		}
		
		public function set buttonFactory(value:IbuttonFactory):void 
		{
			_buttonFactory = value;
			//обновить кнопки
			createDecArrow();
			createIncArrow();
		}
		
		public function set itemFactory(value:IgalleryItemFactory):void 
		{
			if (_itemFactory == value) return;
			_itemFactory = value;
			//Если галерея уже отображена, нужно ее обновить чтобы использовать новую itemFactory
			if (isRendered && _itemFactory) render(); 
		}
		
		public function get isRendered():Boolean 
		{
			return _isRendered;
		}
		
	}

}