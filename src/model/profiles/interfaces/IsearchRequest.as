package model.profiles.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface IsearchRequest 
	{
		function get city():Array
		function get styleG():Vector.<String>
		function get styleY():Vector.<String>
		function get styleR():Vector.<String>
		function get needAudio():Boolean
		function get needVideo():Boolean
		function get localTours():Boolean
		function get worldTours():Boolean
		function get readyForLocalTours():Boolean
		function get readyForWorldTours():Boolean
		function get goalsG():Vector.<String>
		function get goalsY():Vector.<String>
		function get goalsR():Vector.<String>
		function get skillLevel():Array
		function get isForFree():Boolean
		//function get likedTracks():Vector.<String>
		
		function set city(value:Array):void
		function set styleG(value:Vector.<String>):void
		function set styleY(value:Vector.<String>):void
		function set styleR(value:Vector.<String>):void
		function set needAudio(value:Boolean):void
		function set needVideo(value:Boolean):void
		function set localTours(value:Boolean):void
		function set worldTours(value:Boolean):void
		function set readyForLocalTours(value:Boolean):void
		function set readyForWorldTours(value:Boolean):void
		function set goalsG(value:Vector.<String>):void
		function set goalsY(value:Vector.<String>):void
		function set goalsR(value:Vector.<String>):void
		function set skillLevel(value:Array):void
		function set isForFree(value:Boolean):void
		//function set likedTracks(value:Vector.<String>):void
		
	}
	
}