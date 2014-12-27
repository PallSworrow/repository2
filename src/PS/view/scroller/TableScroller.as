package PS.view.scroller 
{
	import flash.geom.Rectangle;
	import PS.model.interfaces.IviewElement;
	import PS.view.layouts.interfaces.IlistLayout;
	import PS.view.scroller.interfaces.Ipage;
	import PS.view.scroller.interfaces.ItableScroller;
	import PS.view.scroller.pages.TableRowPage;
	/**
	 * ...
	 * @author 
	 */
	public class TableScroller extends ListScroller implements ItableScroller
	{
		private var _elementsInPage:int=2;
		private var _inPageInterval:int=0;
		private var pageSize:int = 261;
		
		public function TableScroller(w:int, h:int, vertical:Boolean=true) 
		{
			super(w, h, vertical);
			
		}
		//INNER:
		override protected function createPage(data:Object):Ipage 
		{
			var res:TableRowPage = new TableRowPage();
			res.vertical = !isVertical;
			res.setRectangle(new Rectangle(0, 0, pageSize, pageSize));
			return res;
		}
		private function createItem(data):Ipage
		{
			return super.createPage(data);
		}
		
		
		/* INTERFACE PS.view.scroller.advanced.interfaces.ItableScroller */
		//scroll:
		public function scrollToItem(index:int):void 
		{
			var pageIndex:int = layout.length / elementsInPage;
			scrollToPage(pageIndex);
			
		}
		//content:
		public function addItemTo2(data:Object,page:int, index:int):void 
		{
			
		}
		override public function addItemTo(data:Object, index:int):void 
		{
			//super.addItemTo(data, index);
		}
		override public function addItem(data:Object):int 
		{
			var lastPage:IlistLayout;
			if (layout.length == 0) 
			{
				lastPage = createPage(null) as IlistLayout;
				layout.addItem(lastPage);
			}
			else if ((layout.getItem(layout.length-1) as IlistLayout).length >= elementsInPage)
			{
				lastPage = createPage(null) as IlistLayout;
				layout.addItem(lastPage);
			}
			else 
			{
				
				lastPage = layout.getItem(layout.length - 1) as IlistLayout ;
			}
			lastPage.addItem(createItem(data));
			return getNumItems();
		}
		override public function removeItem(index:int):void 
		{
			if (index < 0) index = 0;
			if (index >= getNumItems()) index = getNumItems() - 1;
			var pageIndex:int = index / elementsInPage;
			//if (index % elementsInPage > 0) pageIndex ++;
			var page:IlistLayout = getPage(pageIndex) as IlistLayout;
			var item:IviewElement = getItem(index);
			page.removeItem(item);
		}
		
		
		public function getNumItems():int 
		{
			//BAD CODE:
			if (layout.length == 0) return 0;
			var lastPage:IlistLayout = layout.getItem(layout.length - 1) as IlistLayout
			return (layout.length -1) * elementsInPage +lastPage.length;
		}
		public function getItem(index:int):IviewElement 
		{
			var pageIndex:int = index / elementsInPage;
			var localIndex:int = index % elementsInPage;
			return getItem2(pageIndex,localIndex);
		}
		
		public function getItem2(page:int, index:int):IviewElement 
		{
			return (layout.getItem(page) as IlistLayout).getItem(index);
		}
		//main:
		override public function update():void 
		{
			super.update();
			var page:IlistLayout;
			for (var i:int = layout.length-1; i >=0 ; i--) 
			{
				page = (layout.getItem(i) as IlistLayout);
				page.pagesInterval = _inPageInterval;
				page.vertical = !isVertical;
				page.update();
			}
		}
		//flags:
		//customize:
		public function get elementsInPage():int 
		{
			return _elementsInPage;
		}
		
		public function set elementsInPage(value:int):void 
		{
			_elementsInPage = value;
			if (autoUpdate) update();
		}
		
		public function set inPageInterval(value:int):void 
		{
			_inPageInterval = value;
			if (autoUpdate) update();
		}
		
		public function get inPageInterval():int 
		{
			return _inPageInterval;
		}
		
	}

}