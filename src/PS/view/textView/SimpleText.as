package PS.view.textView 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import PS.model.interfaces.IviewElement;
	import PS.view.textView.interfaces.ItextBox;
	import view.constants.Fonts;
	
	/**
	 * ...
	 * @author 
	 */
	public class SimpleText extends TextField implements ItextBox 
	{
		
		public function SimpleText( format:TextFormat = null) 
		{
			super();
			//autoSize = 'left';
			embedFonts = true;
			if (format) defaultTextFormat = format;
			else defaultTextFormat = Fonts.SIMPLE;
			selectable = false;
			height = 25;
			wordWrap = true;
			//border = true;
		}
		override public function get type():String 
		{
			
			return super.type;
		}
		
		override public function set type(value:String):void 
		{
			if (value == TextFieldType.INPUT) selectable = true;
			else selectable = false;
			super.type = value;
		}
		/* INTERFACE PS.model.interfaces.IviewElement */
		
		public function addTo(container:DisplayObjectContainer):void 
		{
			container.addChild(this);
		}
		
		public function remove():void 
		{
			if (parent) parent.removeChild(this);
		}
		
		public function dispose():void 
		{
			remove();
		}
		
	}

}