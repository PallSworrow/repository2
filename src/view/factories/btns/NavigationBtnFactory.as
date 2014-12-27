package view.factories.btns {
	import flash.display.Shape;
	import PS.view.button.BtnGroup;
	import PS.view.button.ButtonEvent;
	import PS.view.button.ButtonPhaze;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.button.PsButton;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.textView.SimpleText;
	import view.constants.Fonts;
	/**
	 * ...
	 * @author 
	 */
	public class NavigationBtnFactory implements IbuttonFactory
	{
		private var gr:String;
		public function NavigationBtnFactory(group:String) 
		{
			gr = group;
		}
		
		/* INTERFACE PS.view.factories.interfaces.IbuttonFactory */
		
		public function createButton(text:String):Ibtn 
		{
			var res:PsButton = new PsButton();
			var tf:SimpleText = new SimpleText(Fonts.MAIN_MENU);
			tf.autoSize = 'left';
			tf.multiline = false;
			tf.wordWrap = false;
			tf.text = text;
			var img:Shape = new Shape();
			img.graphics.beginFill(0xffffff);
			img.graphics.drawRect(0, tf.height + 5, tf.width, 4);
			img.graphics.endFill();
			res.addChild(tf);
			res.addViewElement(img, 'line');
			res.setViewHandler(ButtonPhaze.ACTIVE,onActive);
			res.setViewHandler(ButtonPhaze.DEFAULT, onDefault);
			res.group = gr;
			return res;
			
		}
		
		private static function onDefault(items:Object):void 
		{
			
			items.line.alpha = 0;
		}
		
		private static function onActive(items:Object):void 
		{
			
			items.line.alpha = 1;
		}
		
	}

}