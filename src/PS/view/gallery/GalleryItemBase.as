package PS.view.gallery 
{
	import flash.geom.Point;
	import PS.model.BaseSprite;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.Globals;
	import PS.model.PsImage;
	import PS.view.gallery.interfaces.IgalleryItem;
	/**
	 * ...
	 * @author 
	 */
	public class GalleryItemBase extends BaseSprite implements IgalleryItem 
	{
		
		
		
		public static const PROPERTY_LINK:String = 'link';
		public static const PROPERTY_TITLE:String = 'title';
		public static const PROPERTY_CONTENT_TYPE:String = 'contentType';
		
		protected var link:String;
		protected var title:String;
		protected var type:String;
		
		private var _currentData:Object;
		
		private var _needEarlyLoad:Boolean = true;
		private var _isLoaded:Boolean = false;
		private var _isEnabled:Boolean = false;
		public function GalleryItemBase() 
		{
			
		}
		
		
		/* INTERFACE PS.view.gallery.interfaces.IgalleryItem */
		//init->load->enable ... disable-> clear->kill
		
		//INIT|KILL:
		public function init(data:Object):void 
		{
			//	trace('init: ' + data);
			if (!data) data = { };
			try
			{
				link = data[PROPERTY_LINK];
				title  = data[PROPERTY_TITLE];
				type = data[PROPERTY_CONTENT_TYPE];
			}
			catch (e:Error) { }
			_currentData = data;
		}
		public function kill():void 
		{
			if (isLoaded) clear();
			_currentData = null;
			link = null;
			title = null;
			type = null;
			
		}
		
		//LOAD|CLEAR:
		public function load():void 
		{
			_isLoaded = true;
		}
		public function clear():void 
		{
			_isLoaded = false;
			if (isEnabled) disable();
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
		
		
		
		
		//Override base class:
		override public function remove():void 
		{
			kill();
			super.remove();
		}
		
		/* INTERFACE PS.view.gallery.interfaces.IgalleryItem */
		
		
		
		
		
		
		//Public getters:
		public function isTapped(globalPoint:Point):Boolean 
		{
			return false;
		}
		public function get needEarlyLoad():Boolean 
		{
			return _needEarlyLoad;
		}
		public function get isLoaded():Boolean 
		{
			return _isLoaded;
		}
		public function get currentData():Object 
		{
			return _currentData;
		}
		public function get isEnabled():Boolean 
		{
			return _isEnabled;
		}
		//Setters(non interface):
		public function set needEarlyLoad(value:Boolean):void 
		{
			_needEarlyLoad = value;
		}
		
		
	}

}