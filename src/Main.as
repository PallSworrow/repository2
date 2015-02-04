package 
{
	import com.jac.mouse.MouseWheelEnabler;
	import com.junkbyte.console.Cc;
	import com.spikything.utils.MouseWheelTrap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import model.AMini;
	import model.Hierarchy;
	import popupManager.Popup;
	import popupManager.PopupEngine;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.PsImage;
	import PS.view.clouds.CloudWindow;
	import PS.view.clouds.CloudWindowLayers;
	import Swarrow.models.Globals;
	import Swarrow.models.screenManager.implts.ScreenManager;
	import Swarrow.models.screenManager.interfaces.InavigationFilter;
	import Swarrow.models.screenManager.interfaces.IscreenManager;
	import Swarrow.tools.dataObservers.RectangleObserver;
	import view.NavigationPanel;
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		private static var manager:IscreenManager;
		private var navigatePanel:NavigationPanel;
		static public function get screenManager():IscreenManager 
		{
			return manager;
		}
		public function Main():void 
		{
			
			Cc.config.style.backgroundAlpha = 1;
			Cc.startOnStage(this, "`"); // "`" - change for password. This will start hidden
			Cc.visible = true; // Show console, because having password hides console.
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			var ini:AMini = new AMini(800, 600, stage);
			
			//MouseWheelEnabler.init(stage);
			MouseWheelTrap.setup(stage);
			ini.init(onInited,'http://allmusiciants.freevar.com/getSearchData.php?');
		}
		
		private function onInited():void 
		{
			trace(this, 'IINITED');
			CloudWindowLayers.defaultCloudsStage = stage;
			CloudWindowLayers.addLayer('Clouds', stage);
			navigatePanel = new NavigationPanel();
			addChild(navigatePanel);
			//new VectorDispatcher();
			manager = new ScreenManager();
			//trace('PANEL:', navigatePanel.height);
			manager.init(this, new Hierarchy(), new RectangleObserver(0, navigatePanel.height, Globals.width, Globals.height));
			manager.navigationFilters = new Vector.<InavigationFilter>;
			manager.navigationFilters.push(navigatePanel);
			
			manager.loadScreen(Hierarchy.SEARCH_PAGE);
			
		}
		
		
	}
	
}