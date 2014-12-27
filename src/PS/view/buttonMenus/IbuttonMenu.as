package PS.view.buttonMenus {
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IbuttonMenu extends IviewElement
	{
		function get btnNames():Vector.<String>
		function update():void
		//function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		//function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		
		
	}
	
}