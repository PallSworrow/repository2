package 
{
	import com.jac.mouse.MouseWheelEnabler;
	import com.spikything.utils.MouseWheelTrap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import model.AMini;
	import model.Hierarchy;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.PsImage;
	import Swarrow.models.Globals;
	import Swarrow.models.screenManager.implts.ScreenManager;
	import Swarrow.models.screenManager.interfaces.InavigationFilter;
	import Swarrow.models.screenManager.interfaces.IscreenManager;
	import Swarrow.tools.VectorDispatcher;
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
			navigatePanel = new NavigationPanel();
			addChild(navigatePanel);
			//new VectorDispatcher();
			manager = new ScreenManager();
			//trace('PANEL:', navigatePanel.height);
			manager.init(this, new Hierarchy(), new Rectangle(0, navigatePanel.height, Globals.width, Globals.height));
			manager.navigationFilters = new Vector.<InavigationFilter>;
			manager.navigationFilters.push(navigatePanel);
			
			manager.loadScreen(Hierarchy.SEARCH_PAGE);
			
		}
		
		
	}
	
}