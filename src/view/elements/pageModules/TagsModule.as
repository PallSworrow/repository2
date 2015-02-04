package view.elements.pageModules {
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.layouts.implementations.listTyped.StringListLayout_light;
	import PS.view.textView.SimpleText;
	import Swarrow.tools.dataObservers.ArrayObserver;
	import Swarrow.tools.dataObservers.events.ArrayObserverEvent;
	import Swarrow.view.glifs.Glif;
	import Swarrow.view.glifs.GlifEvent;
	import Swarrow.view.layouts.LineLayout;
	import view.constants.Fonts;
	
	/**
	 * ...
	 * @author pall
	 */
	public class TagsModule extends Glif 
	{
		private var list:LineLayout;
		private var _title:SimpleText;
		private var addBtn:Ibtn;
		private var inputTF:SimpleText;
		private var factory:Object;
		private var currValue:ArrayObserver;
		private var _textFromat:TextFormat;
		private var _editable:Boolean;
		private var lastElement:IviewElement;
		public function  TagsModule(name:String, value:ArrayObserver, itemProvider:Object,addBtnProvider:IbuttonFactory, editable:Boolean ) 
		{
			super();
			_editable = editable;
			if (!factory) factory = DefaultButtonFactory.inst;
			factory = itemProvider;
			currValue = value;
			currValue.addEventListener(ArrayObserverEvent.UPDATE, updateList);
			
			addBtn = addBtnProvider.createButton('добавить');
			addBtn.setHandler(onAddBtn);
			
			_title = new SimpleText();
			_title.autoSize = 'left';
			_title.wordWrap = false;
			_title.multiline = false;
			
			inputTF = new SimpleText();
			inputTF.autoSize = 'left';
			inputTF.wordWrap = false;
			inputTF.multiline = false;
			inputTF.selectable = true;
			inputTF.type = TextFieldType.INPUT;
			textFromat = Fonts.SIMPLE;
			
			list = new LineLayout();
			list.intervalX = 5;
			list.autoUpdate = false;
			list.addEventListener(GlifEvent.HEIGHT_CHANGE, list_heightChange);
			
			
			
			addChild(_title);
			addChild(list);
			
			
			title = name;
			if (editable) lastElement = addBtn;
			updateList();
			
			//currValue.addListener(
		}
		
		private function updateList(e:ArrayObserverEvent=null):void 
		{
			var L:int
			if (!e)
			{
				L = currValue.length;
				for (var i:int = 0; i < L; i++) 
				{
					//trace('TEST: ' + value.getItem(i));
					createTagView(String(currValue.getItem(i)));
				}
				
			}
			else
			{
				for (var j:int = 0; j < e.newElenents.length; j++) 
				{
					createTagView(String(e.newElenents[j]));
				}
				for (var k:int = 0; k < e.removedElements.length; k++) 
				{
					killTagView(String(e.removedElements[k]));
				}
			}
			
			if (lastElement)
			{
				list.addElement(lastElement);
			}
			list.update();
		}
		
		private function list_heightChange(e:GlifEvent):void 
		{
			dispatchHeightChange();
		}
		
	
		private function onAddBtn():void 
		{
			list.removeElement(addBtn);
			list.addElement(inputTF);
			list.update();
			lastElement = inputTF;
			
			list.stage.focus = inputTF;
			
			//inputTF.addEventListener(FocusEvent.FOCUS_OUT, cancel);
			inputTF.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			
			function keyDown(e:KeyboardEvent):void
			{
				if (e.keyCode == 13 && stage.focus == inputTF)//enter
				{
					if(inputTF.text != '')
					{
						//list.removeElement(inputTF);
						currValue.push(inputTF.text);
						//list.addItem(createTag(inputTF.text));
						inputTF.text = '';
						//list.addElement(inputTF);
						//list.update();
						list.stage.focus = inputTF;
						//
					}
					else
					cancel();
					
				}
			}
			function cancel(e:FocusEvent=null):void 
			{
				
				list.removeElement(inputTF);
				list.addElement(addBtn);
				lastElement = addBtn;
				inputTF.text = '';
				list.update();
				
			}
		}
		
		override protected function onWidthSet():void 
		{
			
			list.x = _title.width + 5;
			list.width = width - list.x;
			//list.update();
		}
		private function createTagView(name:String):void
		{
			var item:IviewElement;
			if (factory is Function) item =  factory(name);
			else if (factory is IbuttonFactory) item =  factory.createButton(name);
			else throw new Error('invalid itemProvider:' + factory);
			list.addElement(item);
			
			
		}
		private function killTagView(selector:Object):void
		{
			
		}
		//public:
		
		
		
		public function get title():String 
		{
			return _title.text;
		}
		
		public function set title(value:String):void 
		{
			_title.text = value;
			onWidthSet();
		}
		
		public function get textFromat():TextFormat 
		{
			return _title.defaultTextFormat;
		}
		
		public function set textFromat(value:TextFormat):void 
		{
			_title.defaultTextFormat = value;
			inputTF.defaultTextFormat = value;
		}
		
		public function get editable():Boolean 
		{
			return _editable;
		}
		
	}

}