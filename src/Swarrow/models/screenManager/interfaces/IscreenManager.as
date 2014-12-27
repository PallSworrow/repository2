package Swarrow.models.screenManager.interfaces 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;
	import Swarrow.tools.RectangleDispatcher;
	
	/**
	 * ...
	 * @author pall
	 */
	public interface IscreenManager extends IEventDispatcher
	{
		function init(contaimer:DisplayObjectContainer, hierarchy:IscreenHierarchy, rectangle:Rectangle):void
		function set navigationFilters(value:Vector.<InavigationFilter>):void
		function get navigationFilters():Vector.<InavigationFilter>
		function loadScreen(location:Object, data:Object=null):void
		function back(steps:int=1):void
		function get rectangle():RectangleDispatcher
	}
	
}