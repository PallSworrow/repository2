package view.elements 
{
	import flash.text.TextFormat;
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
	/**
	 * ...
	 * @author 
	 */
	public class TextModule extends SimpleTagLayout  
	{
		private var tf:SimpleText;
		private var tfInput:SimpleText;
		private var vm:StringObserver;
		private var editBtn:Ibtn;
		private var confirmBtn:Ibtn;
		private var cancelBtn:Ibtn;
		private var oldValue:String;
		private var editable:Boolean;
		public function TextModule(valueManager:StringObserver,provider:Function, allowEdit:Boolean ) 
		{
			super();
			vm = valueManager;
			editable = allowEdit;
			disposeChildrenOnRemove = false;
			disposeRemovedItems = false;
			tf = provider();
			tf.autoSize = 'left';
			tf.text = vm.currentValue;
			//tf.border = true;
			tfInput = provider();
			tf.autoSize = 'left';
			tfInput.border = true;
			tfInput.type = TextFieldType.INPUT;
			addChild(tf);
			editBtn = DefaultButtonFactory.createBtn('Редактировать');
			editBtn.setHandler(onEditBtn);
			confirmBtn = DefaultButtonFactory.createBtn('ок');
			confirmBtn.setHandler(onEditComplete,true);
			cancelBtn = DefaultButtonFactory.createBtn('отмена');
			cancelBtn.setHandler(onEditComplete, false);
			if (editable)
			{
				addItem(editBtn,'edit');
			}
			update();
			placeMethod = function(root:SimpleTagLayout, elts:Object)
			{
				if (editBtn) editBtn.x = tf.width;
				if (cancelBtn) cancelBtn.x = tfInput.width;
				if (confirmBtn) confirmBtn.x = cancelBtn.x + cancelBtn.width;
			}
		}
		override protected function nativePlaceMethod(item:IviewElement, tag:String):void 
		{
			if (tag == 'edit') item.x = tf.width;
			if (tag == 'cancel') item.x = tfInput.width;
			if (tag == 'ok') item.x = cancelBtn.x + cancelBtn.width;
		}
		protected function onEditBtn():void 
		{
			tf.visible = false;
			editBtn.remove();
			tfInput.text = tf.text;
			addItem(tfInput, 'input');
			addItem(cancelBtn, 'cancel');
			addItem(confirmBtn, 'ok');
			stage.focus = tfInput;
			tfInput.setSelection(tfInput.length, tfInput.length);
			tfInput.addEventListener(Event.CHANGE, tfInput_change);
		}
		
		private function tfInput_change(e:Event):void 
		{
			update();
			
			//dispatchEvent(new Event(Event.CHANGE));
		}
		private function onEditComplete(saveNewVal:Boolean):void
		{
			if (saveNewVal)
			{
				tf.text = tfInput.text;
				save();
			}
			else tfInput.text = tf.text;
			removeByTag('cancel');
			removeByTag('ok');
			removeByTag('input');
			
			tf.visible = true;
			if (editable)
			{
				addItem(editBtn,'edit');
			}
			tfInput.removeEventListener(Event.CHANGE, tfInput_change);
			update();
			
			//dispatchEvent(new Event(Event.CHANGE));
		}
		
		/* INTERFACE view.elements.profilePageModules.interfaces.IprofilePageModule */
		
		
		override public function clear():void
		{
			tf.text = '';
			update();
			tf.removeEventListener(Event.CHANGE, tf_change);
			
		}
		private function tf_change(e:Event):void 
		{
		}
		
		public function save():void 
		{
			vm.currentValue = tf.text;
		}
		
	}

}