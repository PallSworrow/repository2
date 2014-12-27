package PS.view.valueInput.textTyped 
{
	import adobe.utils.CustomActions;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.layouts.implementations.tagTyped.SimpleTagLayout;
	import PS.view.textView.interfaces.ItextBox;
	import PS.view.textView.SimpleText;
	import PS.view.valueInput.interfaces.ItextInput;
	
	/**
	 * ...
	 * @author 
	 */
	public class TextInput extends BaseSprite implements ItextInput
	{
		private static const TAG_TEXT_FIELD:String = 'textfield';
		private static const TAG_TITLE_FIELD:String = 'titlefield';
		
		
		private var layout:SimpleTagLayout;
		
		private var tf:ItextBox;
		private var _enabled:Boolean = false;
		private var _defaultValue:String = '';
		private var _invalidValues:Vector.<String>;
		private var _invalidSymbols:Vector.<String>;
		private var _lengLimit:int;
		private var _text:String='';
		private var _type:String;
		
		
		public function TextInput(rectangle:Rectangle) 
		{
			super();
			layout = new SimpleTagLayout(rectangle);
			layout.placeMethod = placeMethod;
			addElement(layout);
			
			
		}
		public function addtextField(value:ItextBox):void
		{
			tf = value;
			tf.text = _text;
			layout.addItem(value, TAG_TEXT_FIELD);
		}
		public function addTitleField(value:ItextBox):void
		{
			
		}
		
		/* INTERFACE PS.view.valueInput.interfaces.ItextInput */
		
		public function set text(value:String):void 
		{
			_text = value;
			if (tf) tf.text = _text;
		}
		
		public function get text():String 
		{
			return tf.text;
		}
		
		public function appendText(newText:String):void 
		{
			_text += newText;
			if (tf) tf.text = _text;
		}
		
		/* INTERFACE PS.view.valueInput.interfaces.ItextInput */
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		
		protected function placeMethod(item:IviewElement, tag:String):void
		{
			var ttl:IviewElement = layout.getItem(TAG_TITLE_FIELD);
			switch(tag)
			{
				case TAG_TEXT_FIELD:
					if (ttl) item.y = layout.borderUpper + ttl.height;
					else item.y  = layout.borderUpper;
					item.x = layout.borderLeft +(layout.borderWidth - item.width) / 2;
					break;
				case TAG_TITLE_FIELD:
					item.y = layout.borderUpper;
					item.x = layout.borderLeft +(layout.borderWidth - item.width) / 2;
					break;
			}
		}
		
		/* INTERFACE PS.view.valueInput.interfaces.ItextInput */
		
		public function set enabled(value:Boolean):void 
		{
			_enabled = value;
		}
		
		public function set defaultValue(value:String):void 
		{
			_defaultValue = value;
		}
		
		public function set invalidValues(value:Vector.<String>):void 
		{
			_invalidValues = value;
		}
		
		public function set invalidSymbols(value:Vector.<String>):void 
		{
			_invalidSymbols = value;
		}
		
		public function set lengLimit(value:int):void 
		{
			_lengLimit = value;
		}
		
		public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		public function get defaultValue():String 
		{
			return _defaultValue;
		}
		
		public function get invalidValues():Vector.<String> 
		{
			return _invalidValues;
		}
		
		public function get invalidSymbols():Vector.<String> 
		{
			return _invalidSymbols;
		}
		
		public function get lengLimit():int 
		{
			return _lengLimit;
		}
		
	}

}