package view.elements.parts 
{
	import com.greensock.core.SimpleTimeline;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import PS.model.BaseSprite;
	import PS.view.textView.SimpleText;
	
	/**
	 * ...
	 * @author 
	 */
	public class TagView extends BaseSprite 
	{
		private var tf:SimpleText
		public function TagView(value:String) 
		{
			super();
			
			tf = new SimpleText();
			tf.width = 80;
			tf.autoSize = 'left';
			tf.height = 25;
			tf.text = value;
			addChild(tf);
			graphics.beginFill(0xbbbbbb);
			graphics.drawRect(0, 0, tf.width, tf.height);
			graphics.endFill();
			addEventListener(MouseEvent.CLICK, click);
		}
		
		private function click(e:MouseEvent):void 
		{
			dispatchEvent(new Event('TAP'));
		}
		public function getValue():String
		{
			return tf.text;
		}
	}

}