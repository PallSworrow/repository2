package model 
{
	import flash.utils.Dictionary;
	import Swarrow.models.screenManager.bases.HierarchyBase;
	import view.screens.LoadScreen;
	import view.screens.MusicianProfileScreen;
	import view.screens.SearchScreen;
	import view.screens.UserPageScreen;
	
	/**
	 * ...
	 * @author 
	 */
	public class Hierarchy extends HierarchyBase 
	{
		
		public static const MAIN:String = 'main';
		public static const USER_PAGE:String = 'user_page';
		public static const MUSICIAN_PAGE:String = 'musician_page';
		public static const SEARCH_PAGE:String = 'search';
		
		public function Hierarchy() 
		{
			var hierarchy:Object = {}
			hierarchy[MAIN] = new LoadScreen();
			hierarchy[USER_PAGE] = new UserPageScreen();
			hierarchy[MUSICIAN_PAGE] = new MusicianProfileScreen(true);
			hierarchy[SEARCH_PAGE] = new SearchScreen();
			super(hierarchy);
			
		}
		
	}

}