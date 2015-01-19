package view.elements.pageModules {
	import view.elements.pageModules.FlagModule;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import PS.view.button.BtnGroup;
	import PS.view.button.ButtonEvent;
	import PS.view.button.ButtonPhaze;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.scroller.pages.EmptyPage;
	import Swarrow.tools.dataObservers.BooleanObserver;
	
	/**
	 * ...
	 * @author 
	 */
	public class FlagModule extends EmptyPage
	{
		private var vm:BooleanObserver;
		protected var btn:Ibtn;
		private var tf:TextField;
		private var _editable:Boolean;
		public function FlagModule(valueManager:BooleanObserver,btnProvider:Object,name:String, format:TextFormat) 
		{
			if (btnProvider is IbuttonFactory) btn = btnProvider.createButton(name);
			if (btnProvider is Function) btn = btnProvider(name);
			vm = valueManager;
			update();
			addElement(btn);
		}
		public function get editable():Boolean 
		{
			return _editable;
		}
		
		public function set editable(value:Boolean):void 
		{
			_editable = value;
			if (value) btn.group = BtnGroup.TOGLE_SWITCH;
			else btn.group = null;
		}
		private function btn_phazeChanged(e:Event):void 
		{
			vm.currentValue = (btn.phaze == ButtonPhaze.ACTIVE);
			
		}
		/* INTERFACE view.elements.profilePageModules.interfaces.IprofilePageModule */
		
		public function show():void 
		{
			vm.addListener(update);
			
			btn.addEventListener(ButtonEvent.PHAZE_CHANGED, btn_phazeChanged);
		}
		
		private function update():void
		{
			if (vm.currentValue) btn.setPhaze(ButtonPhaze.ACTIVE);
			else btn.setPhaze(ButtonPhaze.DEFAULT);
		}
		
		
		
	
		
		protected function get tfText():String 
		{
			return tf.text;
		}
		
		protected function set tfText(value:String):void 
		{
			tf.text = value;
		}
		
	}

}