package PS.view.previewer.interfaces 
{
	import flash.display.DisplayObject;
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author p.swarrow
	 */
	public interface Ipreviewer extends IviewElement
	{
		function show(item:DisplayObject):void
		function load(link:String):void
		function clear():void
		function set ftsType(value:String):void
		function get ftsType():String
		
		
	}
	
}