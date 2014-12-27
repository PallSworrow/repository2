package PS.model.popupSystem.popups 
{
	import PS.view.factories.interfaces.gallery.IgalleryFactory;
	import PS.model.Globals;
	import PS.model.popupSystem.Popup;
	import PS.view.gallery.events.GalleryEvent;
	import PS.view.gallery.GalleryBase;
	import PS.view.gallery.interfaces.Igallery;
	
	/**
	 * ...
	 * @author 
	 */
	public class GalleryPopup extends Popup 
	{
		public static const GALLERY_DATA_LIST:String = 'galleryDataList';
		public static const PAGE_INDEX:String = 'pageIndex';
		
		private var gallery:Igallery;
		protected var galleryData:Array;
		protected var startPageIndex:int;
		private var galleryProvider:IgalleryFactory;
		public var closeByTap:Boolean = true;
		public function GalleryPopup(galleryFactory:IgalleryFactory=null) 
		{
			galleryProvider = galleryFactory;
			super();
			
			
		}
		//FACTORIES:
		protected function createGallery():Igallery
		{
			return new GalleryBase(Globals.Width, Globals.Height);
		}
		//Gallery event Handlers:
		private function gallery_galleryTap(e:GalleryEvent):void 
		{
			trace('['+this+'] TAP');
			onEmptyTap();
		}
		
		protected function onEmptyTap():void
		{
			if(closeByTap) close();
		}
		//Extension:
		override public function setParameter(name:String, value:Object):void 
		{
			
			checkParameter(name,value);
			super.setParameter(name, value);
		}
		protected function checkParameter(name:String, value:Object):void
		{
			if (name == GALLERY_DATA_LIST) saveDataList(value);
			if (name == PAGE_INDEX && value is Number) startPageIndex = int(value);
			
		}
		protected function saveDataList(data:Object):void
		{
			
			galleryData = [];
			if (data is Array) galleryData= (data as Array);
			else
			{
				for each (var item:Object in data)
				{
					galleryData.push(item);
				}
			}
			
		}
		//SHOW|CLOSE:
		override public function show(parameters:Object = null):void 
		{
			if (isShown) return;
			
			for (var param:String in parameters)
			{
				checkParameter(param, parameters[param]);
			}
			
			if (galleryProvider) gallery = galleryProvider.createGallery(Globals.Width, Globals.Height)
			else gallery = createGallery();
			
			gallery.addEventListener(GalleryEvent.EMPTY_TAP, gallery_galleryTap);
			gallery.setData(galleryData);
			super.show(parameters);
		}
		override public function close(parameters:Object = null):void 
		{
			if (!isShown) return;
			super.close(parameters);
			gallery.removeEventListener(GalleryEvent.EMPTY_TAP, gallery_galleryTap);
			gallery = null;
		}
		
		//DISPLAY|REMOVE:
		override protected function onDisplayed():void 
		{
			super.onDisplayed();
			addElement(gallery);
			gallery.render();
			gallery.pageIndex =startPageIndex;
		}
		override protected function onRemoved():void 
		{
			removeElement(gallery);
			gallery.clear();
			super.onRemoved();
		}
	}

}