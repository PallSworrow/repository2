package PS.view.textView.interfaces 
{
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface ItextBox extends IviewElement
	{
		function set text(value:String):void
		function get text():String
		function set type(value:String):void
		function get type():String
		function appendText(newText:String):void
		
		
		//function addEventListener (type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false) : void;
		//function removeEventListener (type:String, listener:Function, useCapture:Boolean=false) : void;

	}
	
}