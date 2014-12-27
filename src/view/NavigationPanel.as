package view {
	import Swarrow.models.Globals;
	import view.factories.btns.NavigationBtnFactory;
	import flash.display.Sprite;
	import model.Data;
	import model.Embeds;
	import model.Hierarchy;
	import PS.model.BaseSprite;
	import PS.model.dataProcessing.assetManager.EmbedAsset;
	import PS.model.dataProcessing.assetManager.Iasset;
	import PS.model.PsImage;
	import PS.model.ScreenManager;
	import PS.view.button.ButtonPhaze;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.buttonMenus.implementations.BtnListMenu;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.factories.defaults.SimpleBtnFactory;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.layouts.interfaces.IlistLayout;
	import PS.view.previewer.bases.SimplePreview;
	import Swarrow.models.screenManager.interfaces.InavigationFilter;
	import Swarrow.models.screenManager.stuff.NavigatorCommand;
	
	/**
	 * ...
	 * @author 
	 */
	public class NavigationPanel extends BaseSprite implements InavigationFilter
	{
		private var btnProvider:IbuttonFactory = new NavigationBtnFactory('mainMenu');
		private var btnList:BtnListMenu;
		private var profileBtn:Ibtn;
		private var bg:PsImage;
		private var avatar:SimplePreview;
		private var _enabled:Boolean=true;
		public function NavigationPanel() 
		{
			super();
			btnList = new BtnListMenu(Vector.<String>(['Музыканты']));
			btnList.setLayoutProvider(createLayout);
			btnList.setBtnProvider(btnProvider, false);
			btnList.update();
			btnList.handler = onTap;
			
			bg = new PsImage(new EmbedAsset(Embeds.navigP_bg));
			bg.width = Globals.width;
			profileBtn = btnProvider.createButton('Профиль');
			profileBtn.group = 'mainMenu';
			profileBtn.setHandler(onTap, 'Профиль');
			
			
			
			avatar = new SimplePreview(50,50,null,createMask());
			avatar.y = (bg.height-avatar.height) / 2;
			avatar.x = avatar.y;
			try { avatar.load(Data.viewerProfile.photos[0]); }
			catch(e:Error){}
			profileBtn.y = 10;
			profileBtn.x = avatar.x+avatar.width + 20;
			
			btnList.x = bg.width - btnList.width - 20;
			btnList.y = 10;
			
			addChild(bg);
			addChild(avatar);
			addElement(profileBtn);
			addChild(btnList);
			
		}
		
		/* INTERFACE Swarrow.models.screenManager.interfaces.InavigationFilter */
		
		public function set enabled(value:Boolean):void 
		{
			_enabled = value;
		}
		
		public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		public function navigate(command:NavigatorCommand):NavigatorCommand 
		{
			switch(command.destination)
			{
				case Hierarchy.USER_PAGE:
					profileBtn.tap(false);
					break;
				case Hierarchy.SEARCH_PAGE:
					btnList.getBtn('Музыканты').tap(false);
					break;
			}
			return command;
		}
		
		
		private function createMask():Sprite
		{
			var res:Sprite = new Sprite();
			res.graphics.beginFill(0);
			res.graphics.drawCircle(50, 50, 50);
			res.graphics.endFill();
			return res;
		}
		private function onTap(btn:String):void 
		{
			switch(btn)
			{
				case 'Профиль':
					Main.screenManager.loadScreen(Hierarchy.USER_PAGE, Data.viewerProfile);
					break;
				case 'Музыканты':
					Main.screenManager.loadScreen(Hierarchy.SEARCH_PAGE);
					break;
			}
		}
		private function createLayout():IlistLayout
		{
			var res:SimpleListLayout = new SimpleListLayout();
			res.vertical = false;
			res.pagesInterval = 10;
			return res;
		}

	}

}