package PS.view.layouts.interfaces {
	import PS.model.interfaces.Idisplayable;
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface ItagLayout extends Ilayout 
	{
		function addItem(item:IviewElement, tag:String=null):void
		function removeItem(item:IviewElement):void
		function removeByTag(tag:String):void
		function getItem(tag:String):IviewElement
		function getTagOf(item:IviewElement):String
		function get disposeRemovedItems():Boolean
		function set disposeRemovedItems(value:Boolean):void
	}
	
}