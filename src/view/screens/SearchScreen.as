package view.screens 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import model.Data;
	import model.Hierarchy;
	import model.profiles.MusicianProfile;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.layouts.interfaces.IlistLayout;
	import PS.view.previewer.bases.SimplePreview;
	import PS.view.scroller.interfaces.Ipage;
	import PS.view.scroller.ListScroller;
	import PS.view.scroller.pages.EmptyPage;
	import PS.view.textView.SimpleText;
	import Swarrow.models.screenManager.bases.ScreenBase;
	import Swarrow.models.screenManager.interfaces.IscreenManager;
	import Swarrow.tools.RectangleDispatcher;
	import view.constants.Fonts;
	import view.elements.SearchPanelBase;
	import view.elements.UserSearchPanel;
	import view.factories.btns.TagFactory;
	
	/**
	 * ...
	 * @author 
	 */
	public class SearchScreen extends ScreenBase 
	{
		private var scroller:ListScroller;
		private var panel:SearchPanelBase;
		private var searchBtn:Ibtn;
		
		private var loader:URLLoader = new URLLoader();
		public function SearchScreen() 
		{
			super();
			scroller = new ListScroller(200, 100);
			searchBtn = DefaultButtonFactory.createBtn('Найти');
			panel = new UserSearchPanel();
			searchBtn.setHandler(onSearchBtn);
			scroller.itemProvider = itemProvider;
		}
		private static const tagFactory:IbuttonFactory = new TagFactory(0x4444ff);
		private function itemProvider(data:Object):Ipage 
		{
			var res:EmptyPage = new EmptyPage();
			var prof:MusicianProfile = MusicianProfile.parse(String(data));
			var preview:SimplePreview = new SimplePreview();
			var tf0:SimpleText = new SimpleText();
			var tf1:SimpleText = new SimpleText();
			var btn:Ibtn = DefaultButtonFactory.createBtn('Узнать больше');
			var tags:IlistLayout = new SimpleListLayout();
			var layout:IlistLayout = new SimpleListLayout();
			tags.vertical = false;
			
			tf0.autoSize = tf1.autoSize = 'center';
			tf0.defaultTextFormat = Fonts.SIMPLE;
			tf1.defaultTextFormat = Fonts.HINTS;
			tf0.text = prof.name;
			tf1.text = prof.city;
			
			if(prof.photos.length>0)
			preview.load(prof.photos[0]);
			
			tags.pagesInterval = 4;
			var i:int=0
			for each (var tag:String in prof.styles) 
			{
				if (i > 5) break;
				tags.addItem(tagFactory.createButton(tag));
				i++;
			}
			
			layout.x = preview.width + 10;
			res.addChild(preview);
			res.addElement(layout);
			
			layout.addItem(tf0);
			layout.addItem(tf1);
			layout.addItem(tags);
			layout.addItem(btn);
			
			btn.setHandler(onItemTap,prof);
			
			res.graphics.beginFill(0, 0.1);
			res.graphics.drawRect(0, 0, scroller.width, res.height);
			res.graphics.endFill();
			return res;
		}
		private function onItemTap(prof:MusicianProfile):void
		{
			currentManager.loadScreen(Hierarchy.MUSICIAN_PAGE, prof);
		}
		private function onSearchBtn():void 
		{
			clear();
			loader.addEventListener(Event.COMPLETE, loader_complete);
			var req:URLRequest = new URLRequest('http://allmusiciants.freevar.com/userSearch.php?');
			var vars:URLVariables = new URLVariables();
			vars['user_id'] = Data.viewerId;
			vars['request'] = panel.getCurrentReq();
			req.data = vars;
			req.method = URLRequestMethod.POST;
			loader.load(req);
			
			
		}
		override public function clear():void 
		{
			scroller.clear();
			super.clear();
		}
		private function loader_complete(e:Event):void 
		{
			loader.removeEventListener(Event.COMPLETE, loader_complete);
			var searchResult:Array = (e.target.data as String).split('====');
			searchResult = (searchResult[1] as String).split('&&');
			for each (var obj:Object in searchResult) 
			{
				if(obj !='')scroller.addItem(obj);
			}
			
			
			
			
		}
		override public function show(container:DisplayObjectContainer, params:Object, manager:IscreenManager):void 
		{
			addChild(scroller);
			addChild(panel);
			searchBtn.addTo(this);
			super.show(container, params, manager);
		}
		override protected function rectangleChange():void 
		{
			super.rectangleChange();
			panel.width = 200;
			
			scroller.x = rect.x + 25;
			scroller.y = rect.y + 10;
			searchBtn.y = rect.y + 10;
			
			scroller.height = rect.height - 50;
			panel.height = rect.height-panel.y-25
			panel.y = searchBtn.y + searchBtn.height + 5;
			panel.x = rect.bottomRight - panel.width - 25;
			searchBtn.x = panel.x + (panel.width - searchBtn.width) / 2;
			
			scroller.width  = rect.width - scroller.x - (panel.width+25+25);
			
		}
		
	}

}