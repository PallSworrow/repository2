package PS.view.valueInput.interfaces 
{
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface InumberInput extends IviewElement
	{
		function set currentValue(value:Number):void
		function get currentValue():Number
		function set maxValue(value:Number):void
		function get maxValue():Number
		function set minValue(value:Number):void
		function get minValue():Number
		
		function set buttonStep(value:Number):void
		function get buttonStep():Number
		
		function addEventListener (type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false) : void;
		function removeEventListener (type:String, listener:Function, useCapture:Boolean=false) : void;
			
	}
	
}