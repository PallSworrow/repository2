package view.elements.pageModules {
	import adobe.utils.CustomActions;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.globalization.Collator;
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
	import Swarrow.view.layouts.ListLayout;
	
	/**
	 * ...
	 * @author pall
	 */
	public class PortfolioViewer extends ListLayout 
	{
		private var instruments:ArrayObserver;
		private var instrumentsGlifs:Dictionary;
		private var editable:Boolean;
		public function PortfolioViewer(data:ArrayObserver,allowEdit:Boolean) 
		{
			editable = allowEdit;
			instrumentsGlifs = new Dictionary();
			
			super();
			instruments = data;
			instruments.addEventListener(ArrayObserverEvent.SET, show);
			instruments.addEventListener(ArrayObserverEvent.UPDATE, instruments_update);
			show();
		}
		
		
		/*
		 * синхронизировать arrobserver со списком child-ов. через события обсервера.
		 * 
		*/
		private function instruments_update(e:ArrayObserverEvent):void 
		{
			trace(this, 'instruments_update');
			trace(e.newElenents.length, e.removedElements.length);
			var skill:Skill;
			for each(skill in e.newElenents)
			createInstrument(skill);
			for each(var obj:Object in e.removedElements)
			{
				trace(obj);
				removeInstrument(obj);
			}
			update();
		}
		private function createInstrument(data:Skill):void
		{
			var res:SkillView = new SkillView(data,editable);
			instrumentsGlifs[data.type] = res;
			addChild(res);
			
		}
		private function removeInstrument(data:Object):void
		{
			var type:String;
			if (data is Skill) type = data.type;
			else if (data is String) type = String(data);
			else throw new Error('invalid parameter type: ' + data);
			var item:SkillView =  instrumentsGlifs[type];
			if (item) removeChild(item);
			delete instrumentsGlifs[type];
		}
		private function show(e:Event=null)
		{
			trace(this, 'instruments: ' + instruments.length);
			trace(this, 'length: ' + numChildren);
			if(numChildren != instruments.length)
			{
				clear();
				for (var i:int = 0; i < instruments.length; i++) 
				{
					createInstrument(instruments.getItem(i) as Skill);
				}
			}
				
		}
		
	}

}