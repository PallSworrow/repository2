package model.constants 
{
	/**
	 * ...
	 * @author 
	 */
	public class InstrumentTags 
	{
		private static var _list:Object;
		public static function getTags(instrument:String):Vector.<String>
		{
			
		}
		
		static private function get list():Object 
		{
			if (_list) return _list;
			
			_list = { };
			
			//объединить акустиr гитары и электро, сделать доп.список условий (струн \ этнических)
			
			/*_list[InstrumentType.ACOUSTIC_GUITAR] = Vector.<String>(['6 струн', '7 струн', '12 струн']);
			_list[InstrumentType.ELECTRO_GUITAR] = Vector.<String>(['6 струн', '7 струн', '8 струн']);
			_list[InstrumentType.ETHNIC_GUITAR] = Vector.<String>(['Балалайка', 'Банджо', 'Укулеле']);*/
			_list[InstrumentType.GUITAR] = Vector.<String>(['Акустические', 'Электро', 'Этнические']);
			_list[InstrumentType.BASS_GUITAR] = Vector.<String>(['Акустические', 'Электро']);
			_list[InstrumentType.PERCUSSION] = Vector.<String>(['Установка', 'Перкуссия', 'Ханг', 'Другое']);
			_list[InstrumentType.VOCAL] = Vector.<String>(['Чистый', 'Экстримальный', 'Речитатив']);
			_list[InstrumentType.KEYS] = Vector.<String>(['Фортепиано \ Рояль','Синтезатор' /*дублируется и в разделе Электроника - по факту ОДНО И ТО ЖЕ*/]);
			_list[InstrumentType.WIND] = Vector.<String>(['Флейта','Труба','Саксофон','Другое']);
			_list[InstrumentType.BAYANS] = Vector.<String>(['Баян','Аккордеон','Гармонь', 'Другое']);
			_list[InstrumentType.STRING] = Vector.<String>(['Скрипка','Виолончель','Контрабас','Арфа','Другое']);
			_list[InstrumentType.ELECTRONIC] = Vector.<String>(['DJ','Синтезатор','Терменвокс','Другое']);
			_list[InstrumentType.OTHER] = Vector.<String>(['']);
			
			return _list;
		}
		
	}

}

/*
			_list[GenreType.DISCO] = Vector.<String>(['']);
			_list[GenreType.BLUES] = Vector.<String>(['']);
			_list[GenreType.JAZZ] = Vector.<String>(['']);
			_list[GenreType.SYMPHO] = Vector.<String>(['']);
			_list[GenreType.POP] = Vector.<String>(['']);
			_list[GenreType.ROCK] = Vector.<String>(['']);
			_list[GenreType.METAL] = Vector.<String>(['']);
			_list[GenreType.FOLK] = Vector.<String>(['']);
			_list[GenreType.COUNTRY] = Vector.<String>(['']);
			_list[GenreType.ELECTRONIC] = Vector.<String>(['']);
			_list[GenreType.FORRESTORAUNT] = Vector.<String>(['']);
			_list[GenreType.] = Vector.<String>(['']);
			
*/