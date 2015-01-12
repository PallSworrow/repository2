package view.elements.searchmodules {
	import model.constants.RequestParams;
	import model.constants.SkillLevel;
	import model.loadedData.SearchData;
	/**
	 * ...
	 * @author 
	 */
	public class UserSearchPanel extends SearchPanelBase 
	{
		
		public function UserSearchPanel() 
		{
			super();
			
		}
		override protected function init():Array 
		{
			var res:Array = [
				{type:LIST, name: 'Город', list:
					[
						{type:TAGS, name:RequestParams.CITY/*updatable arr*/,title:'Город',values:SearchData.CITIES},
					]
				},
				{type:LIST, name: 'Инструмент', list:
					[
						{type:SELECTOR_STRING, name:RequestParams.INSTRUMENT_TYPE, title:'Выбрать иструмент', values:SearchData.INSTRUMENT_TYPES,
						subEditors:
						[
							{type:TAGS, name:RequestParams.INSTRUMENT_TAGS, title:'Уточнить', values:SearchData.INSTRUMENT_TAGS, necessery:true },
							{type:SELECTOR, name:RequestParams.SKILL_LEVEL , title:'Уровень владения инсрументом', values:SkillLevel.LEVELS, valueFilter:SkillLevel.stringToInt },
							{type:SELECTOR, name:RequestParams.PORTFOLIO_REQUIRED,title:'Портфолио:',values:['Показывать только с портфолио','Обязательно наличие аудио','Обязательно наличие видео','Показывать всех']},
						
						]}
					]
				},
				{type:LIST, name: 'Жанры', list:
					[
						{type:TAGS, name:RequestParams.STYLES, title:'Стили',values:SearchData.STYLES }
					]
				},
				{type:SELECTOR, name:RequestParams.SEARCH_FLAG,title:'Показывать:',values:['Всех','Ищет группу','Ищет музыканта']},
				/*{type:LIST, name: 'Группы-ориентиры', list:
					[
						
					]
				},*/
				{type:LIST, name: 'Расширенный поиск', list:
					[
						{type:TAGS, name:RequestParams.GOALS,title:'Цели',values: SearchData.GOALS},
						{type:FLAG, name:RequestParams.LOCAL_TOURS ,title:'Наличие местных туров'},
						{type:FLAG, name:RequestParams.WORLD_TOURS ,title:'Наличие туров зарубежом'},
						{type:FLAG, name:RequestParams.LOCAL_TOURS_READY ,title:'Готов к местным турам'},
						{type:FLAG, name:RequestParams.WORLD_TOURS_READY ,title:'Готов к международным турам'},
						{type:FLAG, name:RequestParams.IS_FOR_FREE ,title:'Готов играть бесплатно'}
					]
				}
				
			];
			return res;
		}
	}

}