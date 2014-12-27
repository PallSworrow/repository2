package view.elements.searchmodules 
{
	import flash.geom.Rectangle;
	import PS.model.interfaces.IviewElement;
	import PS.view.layouts.implementations.tagTyped.SimpleTagLayout;
	import PS.view.textView.SimpleText;
	import view.constants.Fonts;
	import view.factories.SimpleTextFactory;
	
	/**
	 * ...
	 * @author 
	 */
	public class EditorBase extends SimpleTagLayout 
	{
		//private var _title:String;
		private var _propName:String;
		private var _isNecessery:Boolean = false;
		private var _valueFilter:Function;
		private var _updateHandler:Function;
		private var _uhParams:Object;
		
		public function EditorBase(w:int) 
		{
			
			super(new Rectangle(0, 0, w, 50));
			var tf:SimpleText = SimpleTextFactory.inst.createText();
			tf.defaultTextFormat = Fonts.HINTS
			tf.autoSize = 'left';
			tf.width = w;
			addItem(tf, 'title');
		}
		override protected function nativePlaceMethod(item:IviewElement, tag:String):void 
		{
			switch(tag)
			{
				case 'title':
					//item.x = (borderWidth-item.width) / 2;
					break;
				case 'source':
					item.x = getItem('title').x;
					item.y = getItem('title').y+getItem('title').height;
					break;
				case 'list':
					item.x = getItem('source').x;
					item.y = getItem('source').y+getItem('source').height;
					break;
			}
		}
		public function get title():String 
		{
			return (getItem('title') as SimpleText).text;
		}
		
		public function set title(value:String):void 
		{
			(getItem('title') as SimpleText).text = value;
			update();
		}
		
		public function get propName():String 
		{
			return _propName;
		}
		
		public function set propName(value:String):void 
		{
			_propName = value;
		}
		
		public function get valueFilter():Function 
		{
			return _valueFilter;
		}
		
		public function set valueFilter(value:Function):void 
		{
			_valueFilter = value;
		}
		
		public function get isNecessery():Boolean 
		{
			return _isNecessery;
		}
		
		public function set isNecessery(value:Boolean):void 
		{
			_isNecessery = value;
		}
		public function setUpdateHandler(value:Function,params:Object):void
		{
			_updateHandler = value;
			_uhParams = params;
		}
		protected function callUpdateHandler():void
		{
			if (_updateHandler is Function) _updateHandler(_uhParams);
		}
	}

}