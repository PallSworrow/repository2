package view.elements 
{
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
	import view.constants.Fonts;
	
	/**
	 * ...
	 * @author pall
	 */
	public class TagsModule extends BaseSprite 
	{
		private var list:StringListLayout_light;
		private var _title:SimpleText;
		private var addBtn:Ibtn;
		private var inputTF:SimpleText;
		private var factory:Object;
		private var w:int = 200;
		private var currValue:ArrayObserver;
		private var _textFromat:TextFormat;
		private var _editable:Boolean;
		public function  TagsModule(name:String, value:ArrayObserver, itemProvider:Object,addBtnProvider:IbuttonFactory, editable:Boolean ) 
		{
			super();
			_editable = editable;
			if (!factory) factory = DefaultButtonFactory.inst;
			factory = itemProvider;
			currValue = value;
			currValue.addEventListener(Event.CHANGE, currValue_change);
			
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
			
			list = new StringListLayout_light(new Rectangle(0, 0, w, 0));
			list.autoUpdate = false;
			
			
			
			addChild(_title);
			addChild(list);
			
			
			title = name;
			//currValue.addListener(
		}
		
		private function currValue_change(e:Event=null):void 
		{
			var L:int = currValue.length;
			for (var i:int = 0; i < L; i++) 
			{
				//trace('TEST: ' + value.getItem(i));
				list.addItem(createTag(String(currValue.getItem(i))));
			}
			if (editable) list.addItem(addBtn);
			update();
		}
		
		private function onAddBtn():void 
		{
			list.removeItem(addBtn);
			list.addItem(inputTF);
			list.stage.focus = inputTF;
			inputTF.addEventListener(FocusEvent.FOCUS_OUT, cancel);
			inputTF.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			
			function keyDown(e:KeyboardEvent):void
			{
				if (e.keyCode == 13 && stage.focus == inputTF)//enter
				{
					if(inputTF.text != '')
					{
						list.removeItem(inputTF);
						currValue.push(inputTF.text);
						//list.addItem(createTag(inputTF.text));
						inputTF.text = '';
						list.addItem(inputTF);
						list.stage.focus = inputTF;
					}
					else
					cancel();
					
				}
			}
			function cancel(e:FocusEvent):void 
			{
				
				list.removeItem(inputTF);
				list.addItem(addBtn);
				inputTF.text = '';
				
			}
		}
		
		private function update():void
		{
			list.x = _title.width + 5;
			list.borderWidth = w - list.x;
			list.update();
		}
		private function createTag(name:String):IviewElement
		{
			if (factory is Function) return factory(name);
			else if (factory is IbuttonFactory) return factory.createButton(name);
			else throw new Error('invalid itemProvider:' + factory);
			return null;
		}
		//public:
		
		override public function get width():Number 
		{
			return w;
		}
		
		override public function set width(value:Number):void 
		{
			w = value;
			update();
		}
		
		public function get title():String 
		{
			return _title.text;
		}
		
		public function set title(value:String):void 
		{
			_title.text = value;
			update();
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