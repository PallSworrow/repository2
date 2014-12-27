package model.loadedData 
{
	/**
	 * ...
	 * @author 
	 */
	public class SearchData 
	{
		public static function init(cities:Array, goals:Array,instrumentTypes:Array, instrumentTags:Array,styles:Array):void
		{
			_CITIES = cities;
			_GOALS = goals;
			_INSTRUMENT_TAGS = instrumentTags;
			_STYLES = styles;
			_INSTRUMENT_TYPES = instrumentTypes;
		}
		private static var _CITIES:Array;
		private static var _GOALS:Array;
		private static var _INSTRUMENT_TYPES:Array;
		private static var _INSTRUMENT_TAGS:Array;
		private static var _STYLES:Array
		
		static public function get CITIES():Array 
		{
			return _CITIES;
		}
		
		static public function get GOALS():Array 
		{
			return _GOALS;
		}
		
		static public function get INSTRUMENT_TAGS():Array 
		{
			return _INSTRUMENT_TAGS;
		}
		
		static public function get STYLES():Array 
		{
			return _STYLES;
		}
		
		static public function get INSTRUMENT_TYPES():Array 
		{
			return _INSTRUMENT_TYPES;
		}
		
		
	}

}