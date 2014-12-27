package PS.view.scroller.interfaces 
{
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface Iscroller extends IviewElement
	{
		//maim:
		function scroll(percent:Number):void
		function scroll2(offset:int):void
		function get percent():Number
		function get offset():int
		function set percent(value:Number):void
		function set offset(value:int):void
		
		//function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		//function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		
		//content:
		function addItem(data:Object):int
		function update():void
		function clear():void
		
		//getters:
		function getProportion():Number
		function getMaxOffset():int
		
		//customise:
		function get autoUpdate():Boolean
		function set autoUpdate(value:Boolean):void
		
		function set isVertical(value:Boolean):void
		function get isVertical():Boolean
		
		function set defaultSwipeForce(value:int):void
		function get defaultSwipeForce():int
		
		function get freeSpaceEndSize():int 
		function set freeSpaceEndSize(value:int):void 
		
		function set scrollDuration(value:Number):void
		function set swipeDuration(value:Number):void
		
		function get scrollDuration():Number
		function get swipeDuration():Number
		
		
		//function set width(value:Number):void
		//function set height(value:Number):void
		
	}
	
}