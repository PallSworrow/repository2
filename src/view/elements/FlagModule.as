package view.elements 
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import PS.view.button.BtnGroup;
	import PS.view.button.ButtonEvent;
	import PS.view.button.ButtonPhaze;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.scroller.pages.EmptyPage;
	import Swarrow.tools.valueManagers.interfaces.IboolValueManager;
	
	/**
	 * ...
	 * @author 
	 */
	public class FlagModule extends EmptyPage
	{
		private var vm:IboolValueManager;
		protected var btn:Ibtn;
		private var tf:TextField;
		private var _editable:Boolean;
		public function FlagModule(valueManager:IboolValueManager,btnProvider:Object,name:String, format:TextFormat) 
		{
			if (btnProvider is IbuttonFactory) btn = btnProvider.createButton(name);
			if (btnProvider is Function) btn = btnProvider(name);
			vm = valueManager;
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
			vm.setValue((btn.phaze == ButtonPhaze.ACTIVE));
			save();
		}
		/* INTERFACE view.elements.profilePageModules.interfaces.IprofilePageModule */
		
		public function show():void 
		{
			current = vm.getValue();
			
			btn.addEventListener(ButtonEvent.PHAZE_CHANGED, btn_phazeChanged);
		}
		
		public function save():void 
		{
			vm.setValue(current);
		}
		
		public function get current():Boolean 
		{
			return btn.phaze == ButtonPhaze.ACTIVE;
		}
		
		public function set current(value:Boolean):void 
		{
			
			if (value) btn.setPhaze(ButtonPhaze.ACTIVE);
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