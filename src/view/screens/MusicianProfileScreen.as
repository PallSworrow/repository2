package view.screens 
{
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import model.constants.AMDMpopup;
	import model.constants.InstrumentType;
	import model.constants.SkillLevel;
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
	import view.constants.Fonts;
	import view.elements.pageModules.factories.CheckBoxFactory;
	import view.elements.pageModules.factories.PhotosFactory;
	import view.elements.pageModules.factories.TagModuleFactory;
	import view.elements.pageModules.factories.TextModuleFactory;
	import view.elements.PortfolioViewer;
	import view.elements.TagsModule;
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
			
			var leftColumnWidth:IntegerObserver = new IntegerObserver();
			leftColumnWidth.inherit(rect.wObserver, { multiply:0.6 } );
			var rightColumnWidth:IntegerObserver = new IntegerObserver();
			rightColumnWidth.inherit(rect.wObserver, { multiply:0.4 } );
			
			var res:Array = 
			[
				{type:LAYOUT_TAGS, //HEAD
					markers:{width:rect.wObserver,center:leftColumnWidth},
					placeMethod:function(children:Dictionary, markers:Dictionary):void
					{
						if(children.right)
						{
							children.right.x = markers.center;
						}
					},
					list:
					[
						{type:LAYOUT_LIST, tagName:'left',
							markers:{width:leftColumnWidth},
							list:
							[
								//NAME
								{type:GLIF, 
								params:{font:Fonts.TITLE, manager:profile.name },
								provider:textModuleProvider},
								//CITY
								{type:GLIF,
								params:{font:Fonts.SIMPLE,manager:profile.city },
								provider:textModuleProvider}
								
							]
						},
						{type:LAYOUT_STRING, tagName:'right', 
							markers:{width:rightColumnWidth},
							list:
							[
								//SEARCH FOR MUSICIANS
								{type:GRAPHICS,
								content:createSearchFlag(profile.searchForMusician,HardCodeBtnFactory.S4MUS)}
							]
						}
					]
				},
				{type:LAYOUT_TAGS, //WALL
					markers:{center:leftColumnWidth, width:rect.wObserver},
					placeMethod:function(children:Dictionary,markers:Dictionary):void
					{
						if (children.right)
						{
							children.right.x = markers.center;
						}
					},
					list:
					[
						{type:LAYOUT_LIST, //WALL LEFT
							interval:10,
							markers:{width:leftColumnWidth},
							tagName:'left',
							list:
							[
								//PHOTOS:
								{type:GLIF,
								params:{manager:profile.photos, editable:false },
								provider:photoModuleProvider},
								//STYLES:
								
								{type:GLIF,
								params: { color:0x0044ff, title: 'Стили',editable:false, manager:profile.styles },
								provider:tagsModelProvider},
								//NAVIGATION BUTTONS:
								{type:LAYOUT_STRING, 
									list:
									[
										{type:BUTTON,
										content: HardCodeBtnFactory.inst.createButton(HardCodeBtnFactory.MAIL)}
									]
								},
								
								//INFO|STATUS:
								{type:GRAPHICS, font:Fonts.TITLE, content: 'Статус' },
								{type:GLIF, 
									marakers:{width:leftColumnWidth.currentValue - 160},
									params: 
									{
									provider:createMultiLineText,
									font:Fonts.SIMPLE, manager:profile.info 
									},
									provider:textModuleProvider
								},
								//PORTFOLIO:
								{type:GRAPHICS, font:Fonts.TITLE, content: 'Портфолио' },
								///{type:LAYOUT_LIST, interval:10, list:getPortfolio(profile,centerLine)}
								{type:GRAPHICS,  content:new PortfolioViewer(profile.instruments,leftColumnWidth)}
								
							]
						},
						{type:LAYOUT_LIST, //WALL RIGHT
							tagName:'right',
							list:
							[
								//INSTRUMENT TYPES:
								{type:LIST_MODULE, factory:function(param:Skill):Ibtn
								{
									return InstrumentIconFactory.inst.createButton(param.type);
								},
								editable:false,
								layout:new SimpleListLayout(),
								addMethod:{type:'btn',btn:DefaultButtonFactory.inst,btnName:'добавить',handler:createInstrument, maxItems:InstrumentType.list.length},
								manager:profile.instruments}
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
		private function getPortfolio(prof:MusicianProfile, width:int):Array
		{
			var res:Array = [];
			var item:Object;
			var arr:Array = prof.instruments.currentValue;
			for each (var instrument:Skill in arr) 
			{
				item =
				{
					type:LAYOUT_TAGS,
					placeMethod:portFolioPlaceMethod,
					rectangle:new Rectangle(0, 0, width, 0),
					list:
					[
						//ICON:
						{type:GRAPHICS, tagName:'icon',
						content:InstrumentIconFactory.createIcon(instrument.type)},
						//TAGS:
						{type:GRAPHICS, tagName:'tagsTitle',
						content:'Тэги: ' },
						{type:LIST_MODULE, factory:new TagFactory(0x0044ff),editable:false,
						layout:new StringListLayout_light(new Rectangle(0, 0, width-20, 0)),
						tagName:'tags',
						manager:instrument.tags },
						//AUDIO:
						{type:LIST_MODULE, factory:DefaultButtonFactory.inst,editable:false,
						layout:new StringListLayout_light(new Rectangle(0, 0, width-20, 0)),
						tagName:'audio',
						manager:instrument.audio },
						//VIDEO:
						{type:LIST_MODULE, factory:DefaultButtonFactory.inst,editable:false,
						layout:new StringListLayout_light(new Rectangle(0, 0, width-20, 0)),
						tagName:'video',
						manager:instrument.video }
						
					]
				}
				res.push(item);
			}
			return res;
			function portFolioPlaceMethod(root:SimpleTagLayout, obj:Object):void
			{
				obj.tagsTitle.x = obj.icon.width;
				obj.tags.x = obj.tagsTitle.x + obj.tagsTitle.width;
				obj.audio.x = obj.video.x = obj.tagsTitle.x
			
			
			}
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
			res.autoSize = 'left';
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