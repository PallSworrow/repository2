package PS.model.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface Itransformable extends IviewElement
	{
		function set width(value:Number):void
		function set height(value:Number):void	
		
		function set scaleX(value:Number):void
		function set scaleY(value:Number):void	
		function get scaleX():Number
		function get scaleY():Number	
		
	}
	
}