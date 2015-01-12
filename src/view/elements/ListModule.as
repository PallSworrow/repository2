package view.elements 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextFieldType;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.layouts.implementations.tagTyped.SimpleTagLayout;
	import PS.view.layouts.interfaces.IlistLayout;
	import PS.view.textView.SimpleText;
	import Swarrow.tools.dataObservers.ArrayObserver;
	
	/**
	 * ...
	 * @author pall
	 */
	public class ListModule extends SimpleTagLayout 
	{
		private var manager:ArrayObserver;
		private var _layout:IlistLayout;
		private var itemProvider:Function;
		private var btn:Ibtn;
		private var tf:SimpleText;
		private var methodParams:Object
		private var maxItems:int = 200;
		public function ListModule(itemFactory:Function, listProvider:ArrayObserver,editable:Boolean, addMethod:Object) 
		{
			super();
			autoUpdate = false;
			methodParams = addMethod;
			if (methodParams && editable)
			{
				switch(methodParams.type)
				{
					case 'btn':
						if (methodParams.btn is IbuttonFactory) btn = (methodParams.btn as IbuttonFactory).createButton(methodParams.btnName);
						else if (methodParams.btn is Ibtn) btn = methodParams.btn;
						else throw new Error('invalid btn param: ' + methodParams.btn);
						btn.setHandler(btnHandler, methodParams.handler);
						break;
					case 'input':
						if (methodParams.tf is SimpleText) tf = methodParams.tf;
						else throw new Error('invalid tf param: ' + tf);
						tf.type = TextFieldType.INPUT;
						tf.autoSize = 'none';
						tf.border = true;
						
						if (methodParams.maxChars) tf.maxChars = methodParams.maxChars;
						addItem(tf, 'tf');
						break;
					default:
						throw new Error('invalid addMethod type: '+methodParams.type);
						break;
				}
				if (methodParams.maxItems) maxItems = methodParams.maxItems;
			}
			
			
			manager = listProvider;
			manager.addListener(updateLayout);
			itemProvider = itemFactory;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			placeMethod = updateMethod;
		}
		
		private function btnHandler(handler:Function):void 
		{
			handler(manager.currentValue, 
			function(res:String):void
			{
				addNewItem(res);
			}) ;
			return;
			try { handler(currentList, 
			function(res:String):void
			{
				addNewItem(res);
			}) }
			catch (e:Error) { 
				trace(e.message);
				throw 'button handler must receive current list and handler'; }
			
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			if(tf)stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_keyDown);
						
		}
		
		private function stage_keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == 13 && stage.focus == tf)//enter
			{
				addNewItem(tf.text);
				tf.text = '';
			}
		}
		private function addNewItem(str:String):void
		{
			if (!str || str == '') return;
			manager.push(str);/*
			layout.addItemTo(itemProvider(str), layout.length - 1);
			if (btn &&  manager.length>= maxItems && layout)
			{
				layout.removeItem(btn);
			}
			//save();
			dispatchEvent(new Event(Event.CHANGE));*/
		}
		
		
		private function updateMethod(root:SimpleTagLayout, elts:Object):void
		{
			if (tf && layout)
			{
				layout.y = tf.height;
			}
		}
		
		
		
		public function set layout(value:IlistLayout):void 
		{
			if (layout) layout.dispose();
			_layout = value;
			updateLayout();

		}
		
		private function updateLayout(e:Event=null):void 
		{
			
			if (!layout) return;
			for (var i:int = 0; i < manager.length; i++) 
			{
				layout.addItem(itemProvider(manager.getItem(i)));
			}
			if (btn && manager.length< maxItems)
			{
				layout.addItem(btn);
			}
			if (tf)
			{
				tf.width = layout.borderWidth;
			}
			addItem(layout, 'layout');
			update();
		}
		
		public function get layout():IlistLayout 
		{
			return _layout;
		}
		
	}

}