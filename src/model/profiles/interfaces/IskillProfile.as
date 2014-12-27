package model.profiles.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface IskillProfile 
	{
		function get type():String
		function get tags():Vector.<String>
		function get level():int
		function set level(value:int):void
		function set audio(value:Vector.<String>):void
		function get audio():Vector.<String>
		function set video(value:Vector.<String>):void
		function get video():Vector.<String>
	}
	
}