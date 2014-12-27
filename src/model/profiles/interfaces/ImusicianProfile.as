package model.profiles.interfaces {
	
	/**
	 * ...
	 * @author 
	 */
	public interface ImusicianProfile
	{
		function getStyles():Vector.<String>
		
		function get name():String
		function set name(value:String):void
		
		function get photoUrl():String
		function set photoUrl(value:String):void
		
		function get city():String
		function set city(value:String):void
		
		function get isMusician():Boolean
		function set isMusician(value:Boolean):void
		
		function getSupportedInstruments():Vector.<IskillProfile>
		
		function get isWantToStudy():Boolean
		function getStudingInstruments():Vector.<IskillProfile>
		
		function get isSearchigForMusicants():Boolean
		function getMusicianSearchList():Vector.<IuserSearchRequest>
		
		function get isSearchigForGroups():Boolean
		function getGroupSearchList():Vector.<IgroupSearchRequest>
		
		
		
		
	}
	
}