package PS.view.button.interfaces {
	import PS.view.button.PsButton;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IbtnGroupBehavior 
	{
		function tap(index:int):void
		function init(btnList:Vector.<PsButton>):void
		function dispose():void
	}
	
}