package view.elements.searchmodules 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import PS.model.interfaces.IviewElement;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.clouds.CloudWindow;
	import PS.view.factories.interfaces.ItextFactory;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.layouts.interfaces.IlistLayout;
	import PS.view.textView.SimpleText;
	import view.constants.Fonts;
	import view.elements.parts.HelpWindowElement;
	import view.elements.searchmodules.interfaces.IoptionEditor;
	import view.factories.InputTextFactory;
	import view.factories.SimpleTextFactory;
	/**
	 * ...
	 * @author 
	 */
	public class OptionEditor extends EditorBase implements IoptionEditor
	{
		private var srcProvider:ItextFactory = SimpleTextFactory.inst;
		private var options:Array;
		private var tf:SimpleText;
		private var list:IlistLayout;
		private var btn:Ibtn;
		private var current:int;
		private var _isEmpty:Boolean = false;
		private var cloud:CloudWindow;
		
		public function OptionEditor(values:Array,w:int) 
		{
			super(w);
			options = values;
			tf = srcProvider.createText();
			tf.defaultTextFormat = Fonts.HINTS;
			tf.autoSize = 'left';
			tf.width = w;
			//addItem(_title, 'title');
			list = new SimpleListLayout();
			addItem(tf, 'source');
			//tf.addEventListener(MouseEvent.CLICK, tf_click);
			
			for each(var prop:String in options)
			{
				list.addItem(createValueElement(prop));
			}
			setValue(0);
			
			cloud = new CloudWindow(list as DisplayObject);
			cloud.offsetY = tf.height;
			cloud.init(tf, 'ReqPanel',tf);
		}
		
		
		/*private function tf_click(e:MouseEvent):void 
		{
			addItem(list, 'list');
		}*/
		private function createValueElement(value:String):IviewElement
		{
			var res:HelpWindowElement = new HelpWindowElement(value,tf.width);
			res.addEventListener('TAP', option_tap);
			return res;
		}
		
		private function option_tap(e:Event):void 
		{
			setValue(list.getIndexOf(e.target as HelpWindowElement));
			//list.remove();
			cloud.hide();
		}
		/* INTERFACE view.elements.searchmodules.interfaces.IoptionEditor */
		
		public function getValue():int 
		{
			return current;
		}
		
		public function setValue(value:int):void 
		{
			tf.text = options[value];
			current = value;
		}
		
		public function get isEmpty():Boolean 
		{
			return _isEmpty;
		}
		
	}

}