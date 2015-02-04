package view.popups 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.text.TextFieldType;
	import model.Data;
	import PS.model.popupSystem.Popup;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.textView.SimpleText;
	import Swarrow.models.Globals;
	import Swarrow.tools.dataObservers.ArrayObserver;
	
	/**
	 * ...
	 * @author 
	 */
	public class AddLinkPopup extends Popup 
	{
	
		private var observer:ArrayObserver;
		private var btnProvider:IbuttonFactory  = DefaultButtonFactory.inst;
		//private var 
		
		//glifs:
		private var bg:Shape;
		private var tf:SimpleText;
		private var cancelBtn:Ibtn;
		private var okBtn:Ibtn;
		public function AddLinkPopup() 
		{
			super();
			
			
		}
		private function placeMethod():void
		{
			bg.x = (Globals.width-bg.width) / 2;
			bg.y = (Globals.width - bg.height) / 2;
			
			tf.x = bg.x +10;
			tf.y = bg.y+10;
			tf.width = bg.width - 20;
			
			cancelBtn.y = okBtn.y = bg.y+ bg.height - okBtn.height - 10;
			cancelBtn.x = bg.x+10;
			okBtn.x = bg.x+bg.width - okBtn.width - 10;
		}
		
		
		override public function show(parameters:Object = null):void 
		{
			super.show(parameters);
			observer = parameters.observer;
			
			bg = new Shape();
			bg.graphics.beginFill(0xffffff);
			bg.graphics.drawRect(0,0,500, 200);
			bg.graphics.endFill();
			
			tf = new SimpleText();
			tf.border = true;
			tf.autoSize = 'none';
			tf.selectable = true;
			tf.type = TextFieldType.INPUT;
			cancelBtn = btnProvider.createButton('Отмена');
			okBtn = btnProvider.createButton('Добавить');
			
			
			
			placeMethod();
			addChild(bg);
			addChild(tf);
			addElement(cancelBtn);
			addElement(okBtn);
			
			okBtn.setHandler(onOk);
			cancelBtn.setHandler(close);
			
		}
		
		private function onOk():void 
		{
			observer.push(tf.text);
			close();
		}
		override public function close(parameters:Object = null):void 
		{
			super.close(parameters);
			tf.text = '';
		}
	}

}