package PS.controller {
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class Controller extends EventDispatcher
	{
		public static const TAP:String = 'tap';
		public static const PRESS:String = 'press';
		public static const RELEASE:String = 'release';
		public static const SWIPE:String = 'swipe';
		
		
		private var _startPoint:Point;
		private var _lastPoint:Point;
		
		private var gesDistance:int;
		private var gesTrackLength:int;
		
		
		private var item:InteractiveObject;
		public function Controller() 
		{
			
		}
		public function init(targ:InteractiveObject):void
		{
			item = targ;
			item.addEventListener(MouseEvent.CLICK, mouse_TAP);
			
		}
		
		private function mouse_TAP(e:MouseEvent):void 
		{
		
			_lastPoint = new Point(e.stageX, e.stageY);
			dispatchEvent(new Event(TAP));
		}
		public function disable():void
		{
			
		}
		//MOUSE HANDLERING:
		
		
		
		
		//GETTERS:
		public function get startPoint():Point 
		{
			return _startPoint;
		}
		
		public function get lastPoint():Point 
		{
			return _lastPoint;
		}
		
		
		
		
	}

}