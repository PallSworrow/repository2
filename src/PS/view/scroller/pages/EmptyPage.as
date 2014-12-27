package PS.view.scroller.pages 
{
	import flash.geom.Point;
	import PS.model.BaseSprite;
	import PS.view.scroller.interfaces.Ipage;
	/**
	 * ...
	 * @author 
	 */
	public class EmptyPage extends BaseSprite implements Ipage
	{
		private var _needEarlyLoad:Boolean=false;
		private var _isLoaded:Boolean = false;
		private var _isEnabled:Boolean = false;
		private var _currentData:Object;
		public function EmptyPage() 
		{
			
		}
		
		/* INTERFACE PS.view.scroller.advanced.interfaces.IlistPage */
		
		public function init(data:Object):void 
		{
			_currentData = data;
		}
		public function kill():void 
		{
			_currentData = null;
		}
		
		public function load():void 
		{
			_isLoaded = true;
		}
		public function clear():void 
		{
			if (isEnabled) disable();
			_isLoaded = false;
		}
		
		public function enable():void 
		{
			if (!isLoaded) load();
			_isEnabled = true;
		}
		public function disable():void 
		{
			_isEnabled = false;
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
		
		public function get currentData():Object 
		{
			return _currentData;
		}
		
		public function isTapped(globalPoint:Point):Boolean 
		{
			return false;
		}
		
	}

}