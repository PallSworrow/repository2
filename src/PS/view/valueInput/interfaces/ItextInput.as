package PS.view.valueInput.interfaces 
{
	import PS.model.interfaces.IviewElement;
	import PS.view.textView.interfaces.ItextBox;
	
	/**
	 * ...
	 * @author 
	 */
	public interface ItextInput extends ItextBox
	{
		function set enabled(value:Boolean):void
		function set defaultValue(value:String):void
		function set invalidValues(list:Vector.<String>):void
		function set invalidSymbols(list:Vector.<String>):void
		function set lengLimit(value:int):void
		
		function get enabled():Boolean
		function get defaultValue():String
		function get invalidValues():Vector.<String>
		function get invalidSymbols():Vector.<String>
		function get lengLimit():int
		
	}
	
}