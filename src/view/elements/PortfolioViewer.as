package view.elements 
{
	import adobe.utils.CustomActions;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import model.constants.SkillLevel;
	import model.profiles.Skill;
	import PS.controller.triggers.ItriggerData;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import Swarrow.tools.dataObservers.ArrayObserver;
	import Swarrow.tools.dataObservers.events.ArrayObserverEvent;
	import Swarrow.tools.dataObservers.IntegerObserver;
	
	/**
	 * ...
	 * @author pall
	 */
	public class PortfolioViewer extends SimpleListLayout 
	{
		private var instruments:ArrayObserver;
		private var instrumentsGlifs:Dictionary;
		private var sizeRect:Rectangle;
		private var wObserver:IntegerObserver;
		public function PortfolioViewer(data:ArrayObserver, setWidth:Object) 
		{
			wObserver = setWidth as IntegerObserver;
			if (!wObserver && setWidth is Number) wObserver = new IntegerObserver(Number(setWidth));
			
			instrumentsGlifs = new Dictionary();
			
			super();
			instruments = data;
			instruments.addEventListener(ArrayObserverEvent.SET, show);
			instruments.addEventListener(ArrayObserverEvent.UPDATE, instruments_update);
			autoUpdate = false;
			show();
		}
		/*
		 * синхронизировать arrobserver со списком child-ов. через события обсервера.
		 * 
		*/
		private function instruments_update(e:ArrayObserverEvent):void 
		{
			var skill:Skill;
			for each(skill in e.newElenents)
			createInstrument(skill);
			for each(skill in e.removedElements)
			createInstrument(skill);
		}
		private function createInstrument(data:Skill):void
		{
			var res:SkillView = new SkillView(data, sizeRect);
			instrumentsGlifs[data.type] = res;
			addElement(res);
			
		}
		private function removeInstrument(data:Object):void
		{
			var type:String;
			if (data is Skill) type = data.type;
			else if (data is String) type = String(data);
			else throw new Error('invalid parameter type: ' + data);
			var item:IviewElement =  instrumentsGlifs[type];
			if (item) removeElement(item);
			delete instrumentsGlifs[type];
		}
		private function show(e:Event=null)
		{
			if(length != instruments.length)
			{
				clear();
				for (var i:int = 0; i < instruments.length; i++) 
				{
					createInstrument(instruments.getItem(i) as Skill);
				}
			}
			update();
				
		}
		
	}

}