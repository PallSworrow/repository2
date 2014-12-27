package PS.view.layouts.interfaces {
	import flash.geom.Rectangle;
	import PS.model.interfaces.Idisplayable;
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface Ilayout extends IviewElement
	{
		function setRectangle(rectangle:Rectangle):void
		function get borderLeft():int
		function get borderRight():int
		function get borderUpper():int
		function get borderLower():int
		function get borderWidth():int
		function get borderHeight():int
		function get disposeChildrenOnRemove():Boolean 
		function get autoUpdate():Boolean
		
		function set autoUpdate(value:Boolean):void
		function set disposeChildrenOnRemove(value:Boolean):void 
		function update():void
		
		function set fakeWidth(value:int):void
		function get fakeWidth():int
		function set fakeHeight(value:int):void
		function get fakeHeight():int
		function set fakeSizeEnabled(value:Boolean):void
		function get fakeSizeEnabled():Boolean
		
		function clear():void
	}
	
}