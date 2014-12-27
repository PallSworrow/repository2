package view.elements.parts 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import PS.model.BaseSprite;
	import PS.view.textView.SimpleText;
	import view.factories.SimpleTextFactory;
	
	/**
	 * ...
	 * @author 
	 */
	public class HelpWindowElement extends BaseSprite 
	{
		private var _active:Boolean = false;
		private var tf:SimpleText
		public function HelpWindowElement(value:String,w:int) 
		{
			super();
			tf = SimpleTextFactory.inst.createText();
			tf.autoSize = 'left';
			tf.width = w;
			tf.y = 5;
			tf.text = value;
			addChild(tf);
			addEventListener(MouseEvent.CLICK, click);
			graphics.beginFill(0xdddddd);
			graphics.drawRect(0, 0, w, tf.height+10);
			graphics.endFill();
		}
		
		private function click(e:MouseEvent):void 
		{
			dispatchEvent(new Event('TAP'));
		}
		
		public function get active():Boolean 
		{
			return _active;
		}
		
		public function set active(value:Boolean):void 
		{
			_active = value;
		}
		public function getValue():String
		{
			return tf.text;
		}
		
	}

}