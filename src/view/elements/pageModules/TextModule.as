package view.elements.pageModules {
	import flash.text.TextFormat;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.layouts.implementations.tagTyped.SimpleTagLayout;
	import Swarrow.tools.dataObservers.StringObserver;
	import flash.events.Event;
	import flash.text.TextFieldType;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.scroller.pages.EmptyPage;
	import PS.view.textView.SimpleText;
	import Swarrow.view.glifs.Glif;
	/**
	 * ...
	 * @author 
	 */
	public class TextModule extends Glif  
	{
		private var tf:SimpleText;
		private var vm:StringObserver;
		private var editBtn:Ibtn;
		private var confirmBtn:Ibtn;
		private var cancelBtn:Ibtn;
		private var editable:Boolean;
		private var buttonFactory:IbuttonFactory = DefaultButtonFactory.inst;
		//params:
		private var multiplier:Number=0.6;
		public function TextModule(valueManager:StringObserver,textProperties:Object, allowEdit:Boolean ) 
		{
			super();
			vm = valueManager;
			editable = allowEdit;
			//create
			tf = createTextField(textProperties);
			editBtn = buttonFactory.createButton('Редактировать');
			cancelBtn = buttonFactory.createButton('отмена');
			confirmBtn = buttonFactory.createButton('ок');
			//init
			tf.addEventListener(Event.CHANGE, tf_change);
			tf.text = vm.currentValue;
			editBtn.setHandler(onEdit);
			cancelBtn.setHandler(onCancel);
			confirmBtn.setHandler(onConfirm);
			//place
			placeMethod();
			
			//add
			if (editable) addElement(editBtn);
			addChild(tf);
			
			
		}
		
		
		//inner:
		private function placeMethod()
		{
			tf.width = width * multiplier;
			editBtn.x = cancelBtn.x = tf.width+tf.x;
			confirmBtn.x = cancelBtn.x + cancelBtn.width;
		}
		private function onConfirm():void
		{
			tf.type = TextFieldType.DYNAMIC;
			addElement(editBtn);
			cancelBtn.remove();
			confirmBtn.remove();
			
			vm.currentValue = tf.text;
			
			placeMethod();
			
		}
		private function onCancel():void
		{
			tf.type = TextFieldType.DYNAMIC;
			addElement(editBtn);
			cancelBtn.remove();
			confirmBtn.remove();
			tf.text = vm.currentValue;
			
			placeMethod();
		}
		private function onEdit():void
		{
			tf.type = TextFieldType.INPUT;
			editBtn.remove();
			addElement(cancelBtn);
			addElement(confirmBtn);
			tf.setSelection(tf.length, tf.length);
			stage.focus = tf;
		}
		
		
		
		
		
		//factory:
		function createTextField(props:Object):SimpleText
		{
			var res:SimpleText = props();
			
			
			return res;
		}
		//events:
		override protected function onWidthSet():void 
		{
			placeMethod();
		}
		private function tf_change(e:Event):void 
		{
			placeMethod();
			dispatchHeightChange();
		}
		
	}

}