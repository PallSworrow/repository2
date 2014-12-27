package PS.view.screenSystem 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IscreenManager 
	{
		function  get conatiner():DisplayObjectContainer
		function navigateTo(location:Object, data:Object=null):void
	}
	
}