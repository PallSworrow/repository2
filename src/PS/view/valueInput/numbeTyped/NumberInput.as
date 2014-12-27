package PS.view.valueInput.numbeTyped {
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.layouts.implementations.tagTyped.SimpleTagLayout;
	import PS.view.layouts.interfaces.IlistLayout;
	import PS.view.layouts.interfaces.ItagLayout;
	import PS.view.textView.interfaces.ItextBox;
	import PS.view.valueInput.interfaces.InumberInput;
	/**
	 * ...
	 * @author 
	 */
	public class NumberInput extends BaseSprite implements InumberInput
	{
		public static const INC_BTN:String = 'incbtn';
		public static const DEC_BTN:String = 'decbtn';
		public static const BG:String = 'bg';
		public static const DISPLAY:String = 'display';
		public static const TITLE:String = 'title';
		
		private var _currentValue:Number=0;
		private var _maxValue:Number=100;
		private var _buttonStep:Number=1;
		private var _minValue:Number=0;
		
		private var incArrow:Ibtn; 
		private var decArrow:Ibtn; 
		private var tf:ItextBox;
		private var ttl:ItextBox;
		private var bg:IviewElement;
		private var titleText:String;
		
		private var btnProvider:IbuttonFactory;
		private var layout:SimpleTagLayout;
		public function NumberInput(rect:Rectangle) 
		{
			
			layout = new SimpleTagLayout(rect);
			layout.placeMethod = placeMethod;
			addElement(layout);
			
		}
		override public function dispose():void 
		{
			layout.dispose();
			layout = null;
			super.dispose();
		}
		public function addDecBtn(btn:Ibtn):void
		{
			decArrow = btn;
			decArrow.setHandler(decValue);
			layout.addItem(btn, DEC_BTN);
		}
		public function addIncBtn(btn:Ibtn):void
		{
			incArrow = btn;
			incArrow.setHandler(incValue);
			layout.addItem(btn, INC_BTN);
		}
		public function addBg(background:IviewElement):void
		{
			bg = background;
			layout.addItem(bg, DEC_BTN);
		}
		public function addDisplay(display:ItextBox):void
		{
			tf = display;
			tf.text = String(currentValue);
			layout.addItem(tf, DISPLAY);
		}
		public function addTitle(display:ItextBox):void
		{
			
			ttl = display;
			if (titleText) ttl.text = titleText;
			layout.addItem(ttl, TITLE);
		}
		override public function get name():String 
		{
			return titleText;
		}
		
		override public function set name(value:String):void 
		{
			trace(this, 'set name: ' + value);
			titleText = value;
			if (ttl) ttl.text = titleText;
			if (layout.autoUpdate) layout.update();
		}
	
		
		protected function placeMethod(item:IviewElement, tag:String):void 
		{
			if (tag != TITLE)
			{
				var title:IviewElement = layout.getItem(TITLE);
				if (title)
				{
					item.y = layout.borderUpper + title.height;
				}
				else item.y = layout.borderUpper;
			}
			switch(tag)
			{
				case DEC_BTN:
					item.x = layout.borderLeft;
					break;
				case INC_BTN:
					item.x = layout.borderRight - item.width;
					break;
				case DISPLAY:
				case BG:
					item.x = layout.borderLeft + (layout.borderWidth - item.width) / 2;
					break;
				case TITLE:
					item.y = layout.borderUpper;
					item.x = layout.borderLeft + (layout.borderWidth - item.width) / 2;
				break;
			}
		}
		public function incValue():void
		{
			trace(this, 'TAP');
			currentValue = currentValue+buttonStep;
		}
		public function decValue():void
		{
			currentValue =currentValue- buttonStep;
		}
		
		
		
		/* INTERFACE PS.view.valueInput.interfaces.InumberInput */
		
		public function set currentValue(value:Number):void 
		{
			//if(value == maxValue) dispatchEvent(new Event(NumberInputEvent.UPPER_LIMIT));
			//if(value == minValue) dispatchEvent(new Event(NumberInputEvent.LOWER_LIMIT));
			trace(this, 'setChildIndex value: ' + value);
			trace(this, 'min: ' + minValue);
			trace(this, 'min: ' + maxValue);
			if (value > maxValue) 
			{
				value = maxValue;
				//dispatchEvent(new Event(NumberInputEvent.UPPER_LIMIT_EXCEEDED));
			}
			if (value < minValue)
			{
				value = minValue;
				//dispatchEvent(new Event(NumberInputEvent.LOWER_LIMIT_EXCEEDED));
			}
			//if(_currentValue != value) dispatchEvent(new Event(NumberInputEvent.VALUE_CHANGED));
			trace(this, 'final: ' + value);
			_currentValue = value;
			if (tf) tf.text = String(value);
		}
		
		public function get currentValue():Number 
		{
			return _currentValue;
		}
		
		public function set maxValue(value:Number):void 
		{
			_maxValue = value;
			currentValue=_currentValue;
		}
		
		public function get maxValue():Number 
		{
			return _maxValue;
		}
		
		public function set minValue(value:Number):void 
		{
			_minValue = value;
			currentValue=_currentValue;
		}
		
		public function get minValue():Number 
		{
			return _minValue;
		}
		public function set buttonStep(value:Number):void 
		{
			_buttonStep = value;
		}
		
		public function get buttonStep():Number 
		{
			return _buttonStep;
		}
		
		
		
		
	}

}