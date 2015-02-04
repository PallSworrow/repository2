package view.elements.pageModules.factories 
{
	import flash.display.DisplayObject;
	import model.constants.InstrumentTags;
	import model.profiles.Skill;
	import PS.model.interfaces.IviewElement;
	import PS.model.popupSystem.Ipopup;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.factories.interfaces.IbuttonFactory;
	import Swarrow.tools.dataObservers.ArrayObserver;
	import Swarrow.view.glifs.IglifFactory;
	import view.elements.pageModules.ElementsModule;
	import view.factories.btns.HardCodeBtnFactory;
	import view.factories.InstrumentIconFactory;
	import view.popups.AddInstrumentPopup;
	/**
	 * ...
	 * @author 
	 */
	public class IntrumentsModuleFactory implements IglifFactory
	{
		//HARDCODE!!1!1!!!1!1!1!!!111 1 1 1.. 1.1 1!!! .1.1 ! ! 1 ! ! ! ! SHIT!
		private var itemFactory:InstrumentIconFactory;
		private var manager:ArrayObserver;
		private var btnFactory:IbuttonFactory;
		private var editable:Boolean = false;
		private var module:ElementsModule;
		private var popup:Ipopup;
		public function IntrumentsModuleFactory() 
		{
			popup = new AddInstrumentPopup();
			itemFactory = new InstrumentIconFactory();
			btnFactory = HardCodeBtnFactory.inst;
		}
		
		/* INTERFACE Swarrow.view.glifs.IglifFactory */
		
		public function createGlif(params:Object = null):IviewElement 
		{
			if (params.editable) editable = params.editable;
			manager = params.manager;
			
			module = new ElementsModule(manager, btnFactory, itemProvider, selector, editable, addBtnHandler);
			return module;
		}
		private function selector(data:Skill):String
		{
			return data.type;
		}
		private function itemProvider(data:String):IviewElement
		{
			var res:Ibtn = itemFactory.createButton(data);
			res.setHandler(onItemTap, data);
			(res as DisplayObject).width = (res as DisplayObject).height = 50;
			return res;
		}
		
		private function onItemTap(instType:String):void 
		{
			if (!editable) return;
			
			for (var i:int = 0; i < manager.length; i++) 
			{
				if (manager.getItem(i).type == instType)
				{
					manager.splice(i, 1);
					return;
				}
			}
		}
		private function addBtnHandler():void
		{
			trace('addBtnHandler');
			popup.show( { observer:manager } );
		}
	}

}