package view.elements.searchmodules.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface ItagEditor extends Ieditor
	{
		function getTagsY():Vector.<String>
		function getTagsR():Vector.<String>
		function getTagsG():Vector.<String>
		function setValue(value:Vector.<String>):void
		function addTag(tag:String):void
		function removeTag(index:int):void
		function loadTagList(list:Vector.<String>):void
		
	}
	
}