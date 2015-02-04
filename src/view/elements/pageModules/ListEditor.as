package view.elements.pageModules 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.textView.SimpleText;
	import Swarrow.tools.dataObservers.ArrayObserver;
	import Swarrow.tools.dataObservers.events.ArrayObserverEvent;
	import Swarrow.view.glifs.Glif;
	import Swarrow.view.glifs.GlifEvent;
	import Swarrow.view.layouts.ListLayout;
	
	/**
	 * ...
	 * @author 
	 */
	public class ListEditor extends Glif 
	{
		private var observer:ArrayObserver;
		private var adder:Function;
		private var removeEvent:String = MouseEvent.CLICK;
		private var itemFactory:Function;
		
		private var addBtn:Ibtn;
		private var title:SimpleText;
		private var list:ListLayout;
		
		public function ListEditor(ttl:String, data:ArrayObserver,addHandler:Function) 
		{
			super();
			observer = data;
			observer.addEventListener(ArrayObserverEvent.UPDATE, onDataUpdate);
			title = new SimpleText();
			title.text = ttl;
			
			addBtn = DefaultButtonFactory.createBtn('Добавить');
			addBtn.setHandler(addHandler);
			
			list = new ListLayout();
			list.autoUpdate = false;
			list.addEventListener(GlifEvent.HEIGHT_CHANGE, list_heightChange);
			
			addElement(list);
			addElement(addBtn);
			addElement(title);
			placeMethod();
			onDataUpdate();
		}
		
		private function list_heightChange(e:GlifEvent):void 
		{
			dispatchHeightChange();
		}
		
		private function placeMethod():void 
		{
			addBtn.x = title.width +10;
			list.width = width;
			list.y = title.height +10;
		}
		
		
		
		
		private function onDataUpdate(e:ArrayObserverEvent=null):void
		{
			var element:IviewElement;
			var val:String;
			if (!e)//full update
			{
				list.clear();
				for (var k:int = 0; k < observer.length; k++) 
				{
					val = String(observer.getItem(k));
					element = itemProvider(val);
					
					list.addElement(element);
				}
				list.update();
				return;
			}
			for (var i:int = 0; i < e.newElenents.length; i++) //add
			{
				val = String(e.newElenents[i]);
				element = itemProvider(val);
				list.addElement(element);
				
			}
			for (var j:int = 0; j < e.removedElements.length; j++) //remove
			{
				val = String(e.removedElements[j]);
				list.removeElement(element);
			}
			list.update();
			//placeMethod();
		}
		
		private function itemProvider(val:String):IviewElement 
		{
			var res:SimpleText = new SimpleText();
			res.text = val;
			res.addEventListener(removeEvent, res_removeevent);
			return res;
		}
		
		private function res_removeevent(e:Event):void 
		{
			var index = list.getChildIndex(e.target as DisplayObject);
			observer.splice(index);
		}
		
		
		
		
		override protected function onWidthSet():void 
		{
			super.onWidthSet();
			placeMethod();
		}
		
	}

}