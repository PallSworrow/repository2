package model.constants 
{
	/**
	 * ...
	 * @author 
	 */
	public class InstrumentType 
	{
		/*public static const ACOUSTIC_GUITAR:String = 'Акустические гитары';
		public static const ETHNIC_GUITAR:String = 'Этнические гитары';
		public static const ELECTRO_GUITAR:String = 'Электро гитары';*/
		public static const GUITAR:String = 'гитара';
		public static const BASS_GUITAR:String = 'бас гитара';
		public static const PERCUSSION:String = 'ударные';
		public static const VOCAL:String = 'вокал';
		public static const KEYS:String = 'клавиши';
		public static const WIND:String = 'духовые';
		public static const STRING:String = 'струнные';
		public static const BAYANS:String = 'этнические';
		public static const ELECTRONIC:String = 'электроника';
		public static const OTHER:String = 'другое';
		
		private static var names:Vector.<String>;
		public static function getInstrumentName(type:String):String
		{
		
			return names[type]; 
		}
		public static function get list():Vector.<String>
		{
			if (!names)
			{
				names = Vector.<String>([
				GUITAR, BASS_GUITAR,PERCUSSION,VOCAL,KEYS,WIND,STRING,BAYANS,ELECTRONIC,OTHER
				])
			}
			return names;
		}
		public static function validate(value:String):Boolean
		{
			return list.indexOf(value) >= 0;
		}
	}

}