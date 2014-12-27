package PS.view.clouds.interfaces 
{
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import PS.view.clouds.CloudWindow;
	
	/**
	 * ...
	 * @author 
	 */
	public interface ICWcloseBehavior 
	{
		function init(target:CloudWindow, stage:Stage, trigger:InteractiveObject):void 
		function dispose():void
		function set enabled(value:Boolean):void
		function get enabled():Boolean
	}
	
}