package model.profiles.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface IuserSearchRequest extends IsearchRequest
	{
		function get instrumentType():String
		function set instrumentType(value:String):void
		
		function get instrumentTagsG():Vector.<String>
		function get instrumentTagsY():Vector.<String>
		function get instrumentTagsR():Vector.<String>
		
		function set instrumentTagsG(value:Vector.<String>):void
		function set instrumentTagsY(value:Vector.<String>):void
		function set instrumentTagsR(value:Vector.<String>):void
		
	}
	
}