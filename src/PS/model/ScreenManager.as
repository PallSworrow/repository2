package PS.model 
{
	import flash.display.DisplayObjectContainer;
	import model.Hierarchy;
	import PS.view.screenSystem.Iscreen;
	import PS.view.screenSystem.IscreenManager;
	import Swarrow.view.NavigationPanel;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScreenManager implements IscreenManager 
	{
		private var box:DisplayObjectContainer;
		private var _navigator:NavigationPanel;
		
		private var activeScreen:Iscreen;
		private var currentLoc:int;
		private static var _inst:IscreenManager;
		static public function get inst():IscreenManager 
		{
			return _inst;
		}
		
		
		public function ScreenManager(container:DisplayObjectContainer, navigator:NavigationPanel) 
		{
			_inst = this;
			box = container;
			_navigator = navigator;
		}
		
		/* INTERFACE PS.view.screenSystem.IscreenManager */
		
		public function get conatiner():DisplayObjectContainer 
		{
			return box;
		}
		
		public function navigateTo(location:Object,data:Object=null):void 
		{
			var newScreen:Iscreen = Hierarchy.getScreen(int(location));
			if (_navigator)
			{
				_navigator.onNavigationChange(currentLoc, int(location), data);
				box.y = _navigator.height;
			}
			currentLoc = int(location);
			if (newScreen != activeScreen)
			{
				trace(this , 'new screen: ' + newScreen);
				if (activeScreen) activeScreen.hide();
				activeScreen = newScreen;
				if(activeScreen) activeScreen.show();
			}
			if (activeScreen)
			{
				activeScreen.load(data);
			}
		}
		
	}

}