package PS.view.clouds.interfaces {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.geom.Point;
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IcloudWindow 
	{
		function init( trigger:InteractiveObject, toStage:Object = null, anchor:Object = null):void
		function kill():void
		
		function show():void
		function hide():void
		
		function get offsetX():int 
		function set offsetX(value:int):void 
		function get offsetY():int 
		function set offsetY(value:int):void 
	}
	
}