package model.constants 
{
	/**
	 * ...
	 * @author 
	 */
	public class SkillLevel 
	{
		public static const LEVELS:Array = 
		[
			'Не указан',
			'хер с горы',
			'намана',
			'на уровне пушкина а может быть даже и выше'
		];
		public static function stringToInt(str:String):int
		{
			var index:int = LEVELS.indexOf(str);
			if (index > 0) return index;
			else return 0;
		}
		public static function intToString(i:int):String
		{
			return LEVELS[i];
		}
		public static function get maxLevel():int
		{
			return LEVELS.length - 1;
		}
	}

}