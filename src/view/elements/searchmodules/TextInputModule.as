package view.elements.searchmodules 
{
	import adobe.utils.CustomActions;
	import com.greensock.plugins.TransformMatrixPlugin;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.clouds.CloudWindow;
	import PS.view.factories.interfaces.ItextFactory;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.layouts.implementations.tagTyped.SimpleTagLayout;
	import PS.view.layouts.interfaces.IlistLayout;
	import PS.view.textView.SimpleText;
	import view.constants.Fonts;
	import view.constants.ViewEvent;
	import view.elements.parts.HelpWindowElement;
	import view.elements.searchmodules.interfaces.ItextEditor;
	import view.factories.InputTextFactory;
	import view.factories.SimpleTextFactory;
	
	/**
	 * ...
	 * @author 
	 */
	public class TextInputModule extends EditorBase implements ItextEditor 
	{
		
		private var _source:SimpleText;
		
		private var ttlProvider:ItextFactory = SimpleTextFactory.inst;
		private var srcProvider:ItextFactory = InputTextFactory.inst;
		
		private var _propName:String;
		private var valuesList:Array;
		private var valuesHelp:IlistLayout;
		
		private var _currentValue:String='';
		private var cloud:CloudWindow;
		public function TextInputModule(values:Array,w:int) 
		{
			super(w);
			valuesList = values;
			if (!values) valuesList = [];
			//_title = ttlProvider.createText();
			_source = srcProvider.createText();
			_source.defaultTextFormat = Fonts.HINTS;
			_source.addEventListener(Event.CHANGE, source_textInput);
			//addItem(_title, 'title');
			valuesHelp = new SimpleListLayout();
			addItem(_source, 'source');
			//addItem(valuesHelp, 'list');
			
			
			cloud = new CloudWindow(valuesHelp as DisplayObject);
			cloud.offsetY = _source.height;
			cloud.init(_source, 'ReqPanel',_source);
			
		}
		private function createValueElement(value:String):IviewElement
		{
			var res:HelpWindowElement = new HelpWindowElement(value,_source.width);
			res.addEventListener('TAP', res_tap);
			return res;
		}
		
		private function res_tap(e:Event):void 
		{
			setValue((e.target as HelpWindowElement).getValue());
		}
		private function source_textInput(e:Event):void 
		{
			valuesHelp.clear();
			var curr:String = _source.text.toLocaleLowerCase();
			var val:String;
			for (var i:int = 0; i < valuesList.length; i++) 
			{
				val = String(valuesList[i]).toLocaleLowerCase()
			//trace(this, 'help: ' + curr, val);
				if (curr != '' && val.search(curr) == 0)
				valuesHelp.addItem(createValueElement(valuesList[i]));
			}
			
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
		/* INTERFACE view.elements.searchmodules.interfaces.ItextEditor */
		
		public function getValue():String 
		{
			
			_source.text = _currentValue;
			if (valueFilter is Function) return String(valueFilter(_currentValue));
			else return _currentValue;
		}
		
		public function setValue(value:String):void 
		{
			_currentValue = value;
			_source.text = value;
			valuesHelp.clear();
			callUpdateHandler();
			dispatchEvent(new ViewEvent(ViewEvent.UPDATE));
		}
		
		/* INTERFACE view.elements.searchmodules.interfaces.ItextEditor */
		
		public function get isEmpty():Boolean 
		{
			return (getValue() == '');
		}
		
		/* INTERFACE view.elements.searchmodules.interfaces.ItextEditor */
		
		
		
		
		
	}

}