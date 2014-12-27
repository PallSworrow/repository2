package PS.view.layouts.interfaces {
	import game.model.factories.view.IplayerInfoFactory;
	import game.view.ViewParams;
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface ItableLayout extends Ilayout
	{
		function addItem(item:IviewElement, index_X:int, index_Y:int):void
		function removeItem(item:IviewElement):void
		function removeFrom(index_X:int, index_Y:int):void
		function getItem(index_X:int,index_Y:int):void
	}
	
}