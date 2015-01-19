package view.elements.pageModules 
{
	import adobe.utils.CustomActions;
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import PS.model.interfaces.IviewElement;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.factories.interfaces.IbuttonFactory;
	import Swarrow.tools.dataObservers.ArrayObserver;
	import Swarrow.tools.dataObservers.events.ArrayObserverEvent;
	import Swarrow.view.glifs.Glif;
	import Swarrow.view.glifs.GlifEvent;
	import Swarrow.view.layouts.LineLayout;
	
	/**
	 * ...
	 * @author 
	 */
	public class ElementsModule extends Glif 
	{
		//glifs:
		private var layout:LineLayout;
		private var glifs:Dictionary;
		private var addBtn:Ibtn;
		//data
		private var valueManager:ArrayObserver;
		private var _editable:Boolean = false;
		//properties:
		private var itemProvider:Function;//data(string) -> viewElement
		private var dataProvider:Function;//arr element -> data(string)
		private var addHandler:Function//handler(this)
		
		public function ElementsModule(value:ArrayObserver, btnProvider:IbuttonFactory, glifFactory:Function, selector:Function,allowEditing:Boolean, btnHandler:Function) 
		{
			super();
			itemProvider = glifFactory;
			dataProvider = selector;
			_editable = allowEditing;
			valueManager = value;
			
			//create
			layout = new LineLayout();
			glifs = new Dictionary();
			addBtn = btnProvider.createButton('add');
			addBtn.setHandler(btnHandler);
			
			//init
			layout.autoUpdate = false;
			layout.addEventListener(GlifEvent.HEIGHT_CHANGE, layout_heightChange);
			valueManager.addEventListener(ArrayObserverEvent.UPDATE, valueManager_update);
			
			//place
			
			//add
			addChild(layout);
			valueManager_update();
			
		}
		//methods:
		private function createElement(data:Object):void
		{
			var selector:String = dataProvider(data)
			var item:IviewElement = itemProvider(selector);
			glifs[selector] = item;
			layout.addElement(item);;
			
		}
		private function deleteElement(data:Object):void
		{
			var selector:String = dataProvider(data);
			var item:IviewElement;
			item = glifs[selector];
			delete glifs[selector];
			layout.removeElement(item);
		}
		
		//events:
		private function valueManager_update(e:ArrayObserverEvent=null):void 
		{
			if (e)
			{
				for (var i:int = 0; i < e.newElenents.length; i++) 
				{
					createElement(e.newElenents[i]);
				}
				for (var j:int = 0; j < e.removedElements.length; j++) 
				{
					deleteElement(e.removedElements[i]);
				}
			}
			else
			{
				layout.clear();
				for (var k:int = 0; k < valueManager.length; k++) 
				{
					createElement(valueManager.getItem(i));
				}
			}
			//add btn
			if (editable)
			layout.addElement(addBtn);
			
			layout.update();
		}
		
		private function layout_heightChange(e:GlifEvent):void 
		{
			dispatchWidthChange();
		}
		
		public function get editable():Boolean 
		{
			return _editable;
		}
		
		public function set editable(value:Boolean):void 
		{
			_editable = value;
			
			if (value && !(addBtn as DisplayObject).parent)
			layout.addElement(addBtn);
			else if ((addBtn as DisplayObject).parent)
			layout.addElement(addBtn);
			
		}
		
		
		
	}

}