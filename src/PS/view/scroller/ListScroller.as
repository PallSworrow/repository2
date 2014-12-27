package PS.view.scroller 
{
	import flash.events.Event;
	import PS.controller.events.SwipeEvent;
	import PS.view.scroller.events.ListEvent;
	import PS.view.scroller.interfaces.Ipage;
	import PS.view.scroller.interfaces.IlistScroller;
	import PS.view.layouts.interfaces.IlistLayoutItem;
	/**
	 * ...
	 * @author 
	 */
	public class ListScroller extends SimpleScroller implements IlistScroller
	{
		//interface vars:
		private var _snapToPages:Boolean=true;
		private var _pagesBySwipe:int=1;
		private var _snapDuration:Number=0.4;
		private var _renderZone:int=1;
		private var _preloadZone:int=1;
		private var _updatePageIndexbeforeSwipe:Boolean = true;
		private var _renderControll:Boolean = true
		private var _currentPage:int=0;
		private var prevPage:int = 0;
		private var _autoFreeSpace:Boolean = true;
		
		public function ListScroller(w:int, h:int, vertical:Boolean=true) 
		{
			super(w, h, vertical);
			
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//===================================================== INNER: =======================================================
		
		//tracking current page index:
		override protected function onMoveBegin():void 
		{
			prevPage = currentPage;
			super.onMoveBegin();
		}
		override protected function onMoving(step:int):void 
		{
			
			if (layout.length > 0)
			{
				if (step>0)
				{
					var L:int = layout.length;
					for (var i:int = currentPage; i < L; i++)
					{
						if (offset < layout.getListItem(i).offset + layout.getListItem(i).size/2)
						{
							_currentPage = i;
							break;
						}
					}
				}
				else
				{
					for (var j:int = currentPage; j >= 0; j--)
					{
						if (j != 0)
						{
							if (offset > layout.getListItem(j).offset - layout.getListItem(j - 1).size/2)
							{
								_currentPage = j;
								break;
							}
						}	
						else _currentPage = j;
					}
				}
			}
			//trace('moving... cur page: ' + currentPage);
			super.onMoving(step);
		}
		override protected function onMoveComplete():void 
		{
			//trace('move Complete, dragging: '+isDragging);
			if (!isDragging)
			{
				if (snapToPages) snap();
				if (!isMoving)
				{
					
					super.onMoveComplete();
				}
			}
			checkPages();
		}
		//swiping:
		override protected function onSwipe(swipeDirection:String):void 
		{
			if (!snapToPages) super.onSwipe(swipeDirection);
			else
			{
				var destIndex:int;
				var departIndex:int;
				if (updatePageIndexbeforeSwipe) departIndex = currentPage;
				else departIndex = prevPage;
				
				if ((isVertical && swipeDirection == SwipeEvent.UP) || (!isVertical && swipeDirection == SwipeEvent.LEFT))
					destIndex = departIndex + pagesBySwipe;
				else if ((isVertical && swipeDirection == SwipeEvent.DOWN) || (!isVertical && swipeDirection == SwipeEvent.RIGHT))
					destIndex = departIndex - pagesBySwipe;
				else return;
				
				if (destIndex >= layout.length) destIndex = layout.length - 1;
				if (destIndex < 0) destIndex = 0;
				if (layout.length == 0) return;
				
				innerScrollTo(layout.getListItem(destIndex).offset, swipeDuration);
			}
		}
		//check load|clear:
		private function checkPages():void
		{
			if (!renderControll) return;
			var layoutItem:IlistLayoutItem;
			var page:Ipage
			for (var i:int = layout.length - 1; i >= 0; i--)
			{
				layoutItem = layout.getListItem(i);
				page = layoutItem.item as Ipage;
				if (currentPage >= i && currentPage < i+renderZone)
				{
					if (!page.isEnabled) page.enable();
				}
				else if (currentPage >= i - preloadZone && currentPage < i + renderZone + preloadZone)
				{
					if (!page.isLoaded) page.load();
					else if (page.isEnabled) page.disable();
				}
				else page.clear();
			}
			
		}
		
		
		
		////////////////////////////////////////////////////////////////
		/* =============== INTERFACE PS.view.scroller.advanced.interfaces.IlistScroller ==================================*/
		//scrolling:
		public function scrollToPage(pageIndex:int):void 
		{
			if (pageIndex < 0) pageIndex = 0;
			if (pageIndex >= getNumpages()) pageIndex = getNumpages() - 1;
			scroll2(layout.getListItem(pageIndex).offset);
			
		}
		public function get currentPage():int 
		{
			return _currentPage;
		}
		
		public function set currentPage(value:int):void 
		{
			if (value >= layout.length) value = layout.length - 1;
			if (value < 0) value = 0;
			offset = layout.getListItem(value).offset;
			_currentPage = value;
			//checkPages();
		}		
		public function snap():void 
		{
			
			if (!snapToPages || layout.length == 0) return;
			
			var dest:int = layout.getListItem(currentPage).offset;
			if (dest > maxOffset) dest = maxOffset;
			if (dest == offset) return;
			
			innerScrollTo(dest, snapDuration);
		}
		
		//content:
		public function addItemTo(data:Object, index:int):void 
		{
			var page:Ipage = createPage(data)
			layout.addItemTo(page, index);
			if (!renderControll) page.enable();
			if (autoUpdate) update();
		}
		override public function addItem(data:Object):int 
		{
			var page:Ipage = createPage(data)
			layout.addItem(page);
			if (!renderControll) page.enable();
			if (autoUpdate) update();
			//trace(this, 'addItem height', page.height);
			//trace(this, 'addItem y', page.y);
			return layout.length - 1;
		}
		public function removeItem(index:int):void 
		{
			layout.removeByIndex(index);
			if (autoUpdate) update();
		}
		override public function update():void 
		{
			super.update();
			if (layout.length > 0 && autoFreeSpace) freeSpaceEndSize = layout.getListItem(layout.length - 1).size;
			//else freeSpaceEndSize = 0;
			
			if (renderControll)
			{
				checkPages();
			}
			
		}
		override public function clear():void 
		{
			for (var i:int = layout.length - 1; i >= 0; i--)
			{
				layout.getItem(i).dispose();
				
			}
			
			super.clear();
		}
		//getters:
		public function getNumpages():int 
		{
			return layout.length;
		}
		
		
		public function getPage(index:int):Ipage 
		{
			if (index < 0 || index >= getNumpages()) return null;
			return layout.getItem(index) as Ipage;
		}
		
		/* INTERFACE PS.view.scroller.advanced.interfaces.IlistScroller */
		
		public function get autoFreeSpace():Boolean 
		{
			return _autoFreeSpace;
		}
		
		public function set autoFreeSpace(value:Boolean):void 
		{
			_autoFreeSpace = value;
		}
		
		
	
		
		//customize:
		public function get snapToPages():Boolean 
		{
			return _snapToPages;
		}
		
		public function set snapToPages(value:Boolean):void 
		{
			_snapToPages = value;
		}
		
		public function set pagesBySwipe(value:int):void 
		{
			_pagesBySwipe = value;
		}
		
		public function get pagesBySwipe():int 
		{
			return _pagesBySwipe;
		}
		
		public function set snapDuration(value:Number):void 
		{
			_snapDuration = value;
		}
		
		public function get snapDuration():Number 
		{
			return _snapDuration;
		}
		
		public function get renderZone():int 
		{
			return _renderZone;
		}
		
		public function set renderZone(value:int):void 
		{
			_renderZone = value;
		}
		
		public function get preloadZone():int 
		{
			return _preloadZone;
		}
		
		public function set preloadZone(value:int):void 
		{
			_preloadZone = value;
		}
		
		public function get updatePageIndexbeforeSwipe():Boolean 
		{
			return _updatePageIndexbeforeSwipe;
		}
		
		public function set updatePageIndexbeforeSwipe(value:Boolean):void 
		{
			_updatePageIndexbeforeSwipe = value;
		}
		
		public function get renderControll():Boolean 
		{
			return _renderControll;
		}
		
		public function set renderControll(value:Boolean):void 
		{
			if (value == _renderControll) return;
			if (value) checkPages();
			else
			{
				for (var i:int = layout.length - 1; i >= 0; i--)
				{
					if (!(layout.getItem(i) as Ipage).isEnabled)
					(layout.getItem(i) as Ipage).enable();
				}
			}
			_renderControll = value;
		}
		public function set pagesInterval(value:int):void 
		{
			layout.pagesInterval = value;
			if (autoUpdate) update();
		}
		
		public function get pagesInterval():int 
		{
			return layout.pagesInterval;
		}
		
		/////////////////////////////////////////////////////////////////////
	}

}