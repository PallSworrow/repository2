package Swarrow.tools 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author pall
	 */
	public class RectangleDispatcher extends EventDispatcher
	{
		private var rect:Rectangle;
		public function RectangleDispatcher(rectangle:Rectangle) 
		{
			rect = rectangle;
		}
		private function alarm():void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function update(rectangle:Rectangle):void
		{
			rect = rectangle;
			alarm();
		}
		//setters:
		
		public function set x(value:int):void 
		{
			rect.x = value;
			alarm();
		}
		public function set y(value:int):void
		{
			rect.y = value;
			alarm();
		}
		public function set width(value:int):void
		{
			rect.width = value;
			alarm();
		}
		public function set height(value:int):void
		{
			rect.height = value;
			alarm();
		}
		public function set bottomRight(value:int):void
		{
			rect.width = value-rect.x;
			alarm();
		}
		public function set bottomLower(value:int):void
		{
			rect.height = value-rect.y;
			alarm();
		}
		public function set bottomLeft(value:int):void
		{
			rect.width += rect.x - value;
			rect.x = value;
			alarm();
		}
		public function set bottomUpper(value:int):void
		{
			rect.height += rect.y - value;
			rect.y = value;
			alarm();
		}
		//getters:
		
		public function get x():int 	{return rect.x}
		public function get y():int 	{return rect.y}
		public function get width():int {return rect.width}
		public function get height():int { return rect.height }
		
		public function get bottomRight():int{return rect.x+rect.width}
		public function get bottomLeft():int{return rect.x}
		public function get bottomLower():int{return rect.y+rect.height}
		public function get bottomUpper():int{return rect.y}
		
	}

}