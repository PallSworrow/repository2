package view.elements 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.button.PsButton;
	import PS.view.clouds.CloudWindow;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.textView.SimpleText;
	import Swarrow.tools.valueManagers.interfaces.IboolValueManager;
	import Swarrow.tools.valueManagers.interfaces.IintValueManager;
	import view.factories.SimpleTextFactory;
	
	/**
	 * ...
	 * @author 
	 */
	public class Flag2Module extends FlagModule 
	{
		private var vm:IintValueManager;
		private var options:Vector.<String>;
		private var _currentIndex:int;
		private var tf:SimpleText;
		private var cloud:CloudWindow;
		private var _editable:Boolean;
		public function Flag2Module(valueManager:IintValueManager, btnProvider:Object, name:String,valueOptions:Vector.<String>,format:TextFormat) 
		{
			tf = SimpleTextFactory.inst.createText();
			tf.autoSize = 'left';
			tf.multiline = false;
			tf.wordWrap = false;
			addChild(tf);
			vm = valueManager;
			options = valueOptions;
			super( null, btnProvider, name, format);
			
			var list:SimpleListLayout = new SimpleListLayout();
			
			for each(var option:String in valueOptions) list.addItem(createOptionItem(option));
			cloud = new CloudWindow(list);
			cloud.offsetY = btn.height;
			
			btn.setHandler(cloud.show);
			
		}
		override public function get editable():Boolean 
		{
			return _editable;
		}
		
		override public function set editable(value:Boolean):void 
		{
			if (_editable == value) return;
			_editable = value;
			if (value) cloud.init(this, 'Clouds', this);
			else cloud.kill();
		}
		private function createOptionItem(str:String):IviewElement
		{
			var res:PsButton = new PsButton();
			var tf:SimpleText = new SimpleText();
			tf.text = str;
			tf.background = true;
			res.addChild(tf);
			res.setHandler(optionClick, str);
			return res;
		}
		
		private function optionClick(val:String):void 
		{
			var index:int = options.indexOf(val);
			currentIndex = index;
			cloud.hide();
			save();
		}
		
		
		
		
		override public function show():void 
		{
			currentIndex = vm.getValue();
			if (currentIndex == 0) current = false;
			else current = true;
		}
		override public function save():void 
		{
			vm.setValue(currentIndex);
			//saveHandler();
		}
		
		public function get currentIndex():int 
		{
			return _currentIndex;
		}
		
		public function set currentIndex(value:int):void 
		{
			_currentIndex = value;
			if (value < options.length) 
			{
				tf.text = options[value];
				tf.x = btn.width;
			}
			if (value == 0) current = false;
			else current = true;
		}
	}

}