package view.screens 
{
	import adobe.utils.CustomActions;
	import com.junkbyte.console.Cc;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import model.profiles.MusicianProfile;
	import PS.model.BaseSprite;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.interfaces.IviewElement;
	import PS.model.PsImage;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.button.PsButton;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.layouts.implementations.listTyped.StringListLayout_light;
	import PS.view.layouts.implementations.tagTyped.SimpleTagLayout;
	import PS.view.layouts.interfaces.Ilayout;
	import PS.view.layouts.interfaces.IlistLayout;
	import PS.view.scroller.events.ScrollerEvent;
	import PS.view.scroller.ListScroller;
	import PS.view.scroller.ScrollBar;
	import PS.view.textView.SimpleText;
	import Swarrow.models.screenManager.interfaces.IscreenManager;
	import flash.display.DisplayObjectContainer;
	import Swarrow.models.screenManager.bases.ScreenBase;
	import Swarrow.view.glifs.GlifEvent;
	import Swarrow.view.glifs.IglifFactory;
	import Swarrow.view.glifs.TableMaker;
	import Swarrow.view.layouts.LayoutBase;
	import Swarrow.view.layouts.LineLayout;
	import Swarrow.view.layouts.ListLayout;
	import Swarrow.view.layouts.ColumnsLayout;
	import view.constants.Fonts;
	import view.elements.pageModules.Flag2Module;
	import view.elements.pageModules.FlagModule;
	import view.elements.pageModules.factories.GlifFactory;
	import view.elements.pageModules.Photo3Module;
	import view.elements.pageModules.TextModule;
	
	/**
	 * ...
	 * @author 
	 */
	public class ProfileScreenBase extends ScreenBase 
	{
		
		
		private var scroller:ListScroller;
		private var sb:ScrollBar;
		private var backBtn:Ibtn;
		private var _allowBack:Boolean;
		private var _tableMaker:TableMaker;
		public function ProfileScreenBase(allowBack:Boolean) 
		{
			super();
			_allowBack = allowBack;
			_tableMaker = new TableMaker();
			scroller = new ListScroller(200, 100);
			scroller.autoFreeSpace = false;
			var sp:Sprite = new Sprite();
			sp.addChild(new PsImage(new ColorAsset(20, 20)));
			sb = new ScrollBar(100, new PsImage(new ColorAsset(20, 100)), sp );
			sb.addEventListener(ScrollerEvent.SCROLL, function(e:Event):void { scroller.percent = sb.percent} );
			scroller.draggable = false;
			//scroller.itemProvider = render;
			scroller.snapToPages = false;
			backBtn = DefaultButtonFactory.createBtn('Back');
			addChild(scroller);
			addChild(sb);
			
		}
		override public function show(container:DisplayObjectContainer, params:Object, manager:IscreenManager):void 
		{
			super.show(container, params, manager);
			if (_allowBack)
			{
				backBtn.setHandler(currentManager.back);
				backBtn.addTo(this);
			}
			
		
		}
		override protected function rectangleChange():void 
		{
			super.rectangleChange();
			if (_allowBack)
			{
				backBtn.y = rect.y;
				scroller.y = backBtn.y + backBtn.height;
			}
			else scroller.y = rect.y;
			trace('SCREEN: ' + rect.y);
			scroller.height = rect.height+rect.y - scroller.y;
			scroller.width = rect.width-30;
			
			sb.y = scroller.y;
			sb.x = scroller.x + scroller.width + 5;
			sb.setIndicatorBoxSize(scroller.height);
			/*
			graphics.clear();
			graphics.beginFill(0,1);
			graphics.drawRect(0, scroller.y, 100, 100);
			graphics.endFill();*/
			
		}
		override public function hide():void 
		{
			clear();
			super.hide();
			
		}
		
		override public function load(data:Object = null):void 
		{
			super.load(data);
			if (data) clear();
			else return;
			
			Cc.ch(this,' LOAD DATA \n' + JSON.stringify(data));
			
			
			var items:Array = read(data);
			var element:IviewElement;
			Cc.ch(this, 'data length: ' + items.length);
			try{
			for each (var item:Object in items) 
			{
				element = render(item);
				(element as DisplayObject).width = scroller.width;
				element.addEventListener(GlifEvent.HEIGHT_CHANGE, element_change);
				scroller.addItem(element);
				
				
			}
			}
			catch (e:Error)
			{
				Cc.ch(this, 'RENDERING ERROR: ' +e);
				Cc.ch(this,e.message);
				Cc.ch(this, e.getStackTrace);
			}
			scroller.update()
			Cc.ch(this,'scroller length: ' + scroller.getNumpages());
			sb.proportion = scroller.getProportion();
		}
		
		private function render(item:Object):IviewElement 
		{
			return tableMaker.createGlif(item);
		}
		
		private function element_change(e:Event):void 
		{
			scroller.update();
			sb.proportion = scroller.getProportion();
		}
		override public function clear():void 
		{
			scroller.clear();
			super.clear();
		}
		
		
		protected function read(data:Object):Array
		{
			throw 'this method must be overrided';
			return null;
		}
		
		
	
		
	/*	protected function createListModule(data:Object):IviewElement
		{
			var provider:Function;
			if (data.factory is Function) provider = data.factory;
			if (data.factory is IbuttonFactory) 
			provider = (data.factory as IbuttonFactory).createButton;
			
			var lm:ListModule = new ListModule(provider, data.manager, data.editable,data.addMethod);
			if (data.layout is Function) data.layout = data.layout();
			if (data.layout is IlistLayout) lm.layout = data.layout;
			else throw new Error('invalid data.layout param: ' + data.layout);
			return lm;
		}
		*/
		public function get tableMaker():TableMaker 
		{
			return _tableMaker;
		}
		/*protected function createCheckBox(data:Object):IviewElement
		{
			var res:FlagModule;
			var format:TextFormat;
			if (data.font is TextFormat) format = data.font;
			else format = Fonts.SIMPLE;
			
			if (data.manager is IintValueManager)
			{
				res = new Flag2Module(data.manager as IintValueManager, 
				data.factory,
				String(data.name), 
				data.options,
				format);
			}
			else
			{
				res = new FlagModule(data.manager as IboolValueManager,
				data.factory,
				String(data.name),
				format);
			}
			return res;
		}
		*/
	}
	

}