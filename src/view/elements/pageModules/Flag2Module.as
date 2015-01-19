package view.elements.pageModules {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.button.ButtonPhaze;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.button.PsButton;
	import PS.view.clouds.CloudWindow;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.textView.SimpleText;
	import Swarrow.tools.dataObservers.IntegerObserver;
	import view.factories.SimpleTextFactory;
	
	/**
	 * ...
	 * @author 
	 */
	public class Flag2Module extends BaseSprite 
	{
		//data:
		private var vm:IntegerObserver;
		private var options:Vector.<String>;
		private var _editable:Boolean;
		//glifs:
		private var tf:SimpleText;
		private var valueTf:SimpleText;
		private var btn:Ibtn;
		private var cloud:CloudWindow;
		public function Flag2Module(valueManager:IntegerObserver, name:String,btnProvider:IbuttonFactory, valueOptions:Vector.<String>,format:TextFormat) 
		{
			
			vm = valueManager;
			options = valueOptions;
			//create glif:
			tf = SimpleTextFactory.inst.createText();
			tf.autoSize = 'left';
			tf.multiline = false;
			tf.wordWrap = false;
			tf.text = name;
			
			valueTf = SimpleTextFactory.inst.createText();
			valueTf.autoSize = 'left';
			valueTf.multiline = false;
			valueTf.wordWrap = false;
			valueTf.text = options[vm.currentValue];
			
			btn = btnProvider.createButton('ololo');
			if (vm.currentValue > 0) btn.setPhaze(ButtonPhaze.ACTIVE);
			
			tf.x = btn.width;
			valueTf.x = tf.x + tf.width;
			
			addElement(btn);
			addChild(tf);
			addChild(valueTf);
			
			
			//create cloude:
			var list:SimpleListLayout = new SimpleListLayout();
			for each(var option:String in valueOptions) list.addItem(createOptionItem(option));
			cloud = new CloudWindow(list);
			cloud.offsetY = btn.height;
			
			btn.setHandler(cloud.show);
			
		}
		
		private function createOptionItem(option:String):IviewElement 
		{
			var tf:SimpleText = new SimpleText();
			tf.wordWrap = false;
			tf.multiline = false;
			tf.autoSize = 'left';
			tf.text = option;
			return tf;
		}
		public function get editable():Boolean 
		{
			return _editable;
		}
		
		public function set editable(value:Boolean):void 
		{
			if (_editable == value) return;
			_editable = value;
			if (value) cloud.init(this, 'Clouds', this);
			else cloud.kill();
		}
		/*private function createOptionItem(str:String):IviewElement
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
		}*/
	}

}