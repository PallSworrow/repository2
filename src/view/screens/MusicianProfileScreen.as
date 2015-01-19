package view.screens 
{
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import model.constants.AMDMpopup;
	import model.constants.InstrumentType;
	import model.constants.SkillLevel;
	import model.Data;
	import model.Embeds;
	import model.profiles.interfaces.IskillProfile;
	import model.profiles.MusicianProfile;
	import model.profiles.Skill;
	import PS.model.interfaces.IviewElement;
	import PS.model.popupSystem.PopupManager;
	import PS.view.button.ButtonPhaze;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.layouts.implementations.listTyped.StringListLayout_light;
	import PS.view.layouts.implementations.tagTyped.SimpleTagLayout;
	import PS.view.textView.SimpleText;
	import Swarrow.tools.dataObservers.IntegerObserver;
	import Swarrow.tools.dataObservers.RectangleObserver;
	import Swarrow.view.glifs.TableMaker;
	import view.constants.Fonts;
	import view.elements.pageModules.factories.CheckBoxFactory;
	import view.elements.pageModules.factories.IntrumentsModuleFactory;
	import view.elements.pageModules.factories.PhotosFactory;
	import view.elements.pageModules.factories.TagModuleFactory;
	import view.elements.pageModules.factories.TextModuleFactory;
	import view.elements.pageModules.PortfolioViewer;
	import view.elements.pageModules.TagsModule;
	import view.factories.btns.HardCodeBtnFactory;
	import view.factories.btns.TagFactory;
	import view.factories.InstrumentIconFactory;
	/**
	 * ...
	 * 
	 * @author 
	 */
	public class MusicianProfileScreen extends ProfileScreenBase
	{
		
		protected var _editable:Boolean;
		protected var textModuleProvider:TextModuleFactory;
		protected var photoModuleProvider:PhotosFactory;
		protected var checkBoxProvider:CheckBoxFactory;
		protected var tagsModelProvider:TagModuleFactory;
		public function MusicianProfileScreen(allowBack:Boolean = false) 
		{
			super(allowBack);
			_editable = false;
			textModuleProvider = new TextModuleFactory( { maxChars:30, provider:createSingLineText } );
			photoModuleProvider = new PhotosFactory();
			checkBoxProvider = new CheckBoxFactory();
			tagsModelProvider = new TagModuleFactory();
		}
		protected var profile:MusicianProfile;
		override protected function read(data:Object):Array 
		{
			profile = data as MusicianProfile;
			if (!profile) throw new Error('invaslid input data: ' + data);
			
			editable = (profile.id == Data.viewerProfile.id);
			var columns:Array = ['60%',{paddingLeft:'5%',width:'35%'}]
			
			var res:Array = 
			[
				{type:TableMaker.COLUMNS, //HEAD
					placeMethod:columns,
					list:
					[
						{type:TableMaker.LIST, 
							list:
							[
								//NAME
								{type:TableMaker.GLIF, 
								params:{font:Fonts.TITLE, manager:profile.name , editable:editable},
								provider:textModuleProvider},
								//CITY
								{type:TableMaker.GLIF,
								params:{font:Fonts.SIMPLE,manager:profile.city , editable:editable},
								provider:textModuleProvider}
								
							]
						},
						{type:TableMaker.STRING,
							list:
							[
								//SEARCH FOR MUSICIANS
								{type:TableMaker.GRAPHICS,
								content:createSearchFlag(profile.searchForMusician,HardCodeBtnFactory.S4MUS)}
							]
						}
					]
				},
				{type:TableMaker.COLUMNS, //WALL
					placeMethod:columns,
					list:
					[
						{type:TableMaker.LIST, //WALL LEFT
							interval:10,
							list:
							[
								//PHOTOS:
								{type:TableMaker.GLIF,
								params:{manager:profile.photos, editable:editable },
								provider:photoModuleProvider},
								//STYLES:
								
								{type:TableMaker.GLIF,
								params: { color:0x0044ff, title: 'Стили', editable:editable, manager:profile.styles },
								provider:tagsModelProvider},
								//NAVIGATION BUTTONS:
								{type:TableMaker.STRING, 
									list:
									[
										{type:TableMaker.BUTTON,
										content: HardCodeBtnFactory.inst.createButton(HardCodeBtnFactory.MAIL)}
									]
								},
								
								//INFO|STATUS:
								{type:TableMaker.GRAPHICS, font:Fonts.TITLE, content: 'Статус' },
								{type:TableMaker.GLIF, 
									params: 
									{
									provider:createMultiLineText,
									font:Fonts.SIMPLE, manager:profile.info , editable:editable
									},
									provider:textModuleProvider
								},
								//PORTFOLIO:
								{type:TableMaker.GRAPHICS, font:Fonts.TITLE, content: 'Портфолио' },
								{type:TableMaker.GLIF,  provider:new PortfolioViewer(profile.instruments,editable)}
								
							]
						},
						{type:TableMaker.LIST, //WALL RIGHT
							list:
							[
								//INSTRUMENT TYPES:
								{type:TableMaker.GLIF,
									params:{editable:editable,manager:profile.instruments},
									provider:new IntrumentsModuleFactory()
								}
							]
						}
					]	
				}
			];
			return res;
		}
		private function createInstrument(list:Vector.<String>, handler:Function):void
		{
			PopupManager.showPopup(AMDMpopup.ADD_INSTRUMENT_TYPE, { list:list,handler:handler} );
		}
		
		private function createSearchFlag(phaze:Boolean, type:String):IviewElement
		{
			var res:Ibtn = HardCodeBtnFactory.inst.createButton(type);
			if (phaze) res.setPhaze(ButtonPhaze.ACTIVE);
			return res;
		}
		private function createSingLineText():SimpleText
		{
			var res:SimpleText = new SimpleText();
			res.autoSize = 'left';
			res.wordWrap = false;
			res.multiline = false;
			return res;
		}
		private function createMultiLineText():SimpleText
		{
			var res:SimpleText = new SimpleText();
			res.autoSize = 'center';
			res.wordWrap = true;
			res.multiline = true;
			return res;
		}
		
		public function get editable():Boolean 
		{
			return _editable;
		}
		
		public function set editable(value:Boolean):void 
		{
			_editable = value;
		}
	}

}