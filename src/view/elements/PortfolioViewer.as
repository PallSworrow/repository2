package view.elements 
{
	import adobe.utils.CustomActions;
	import flash.geom.Rectangle;
	import model.profiles.Skill;
	import PS.controller.triggers.ItriggerData;
	import PS.model.BaseSprite;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import Swarrow.tools.dataObservers.ArrayObserver;
	import Swarrow.tools.dataObservers.IntegerObserver;
	
	/**
	 * ...
	 * @author pall
	 */
	public class PortfolioViewer extends SimpleListLayout 
	{
		private var instruments:ArrayObserver;
		private var sizeRect:Rectangle;
		private var wObserver:IntegerObserver;
		public function PortfolioViewer(data:ArrayObserver, setWidth:Object) 
		{
			wObserver = setWidth as IntegerObserver;
			if (!wObserver && setWidth is Number) wObserver = new IntegerObserver(Number(setWidth));
			
			super();
			instruments = data;
			instruments.addListener(show);
			autoUpdate = false;
			show();
		}
		private function createInstrument(data:Skill)
		{
			var res:SkillView = new SkillView(data, sizeRect);
			return res;
		}
		private function show()
		{
			if(length != instruments.length)
			{
				clear();
				for (var i:int = 0; i < instruments.length; i++) 
				{
					addChild(createInstrument(instruments.getItem(i) as Skill));
				}
			}
			update();
				
		}
		
	}

}