package view.factories.btns {
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.PsImage;
	import PS.view.button.BtnGroup;
	import PS.view.button.ButtonPhaze;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.button.PsButton;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.textView.SimpleText;
	import view.factories.SimpleTextFactory;
	
	/**
	 * ...
	 * @author 
	 */
	public class FlagFactory implements IbuttonFactory 
	{
		public static const inst:FlagFactory = new FlagFactory();
		public function FlagFactory() 
		{
			
		}
		
		/* INTERFACE PS.view.factories.interfaces.IbuttonFactory */
		
		public function createButton(text:String):Ibtn 
		{
			var res:PsButton = new PsButton(BtnGroup.TOGLE_SWITCH);
			var tf:SimpleText = SimpleTextFactory.inst.createText();
			var img0:PsImage = new PsImage(new ColorAsset(10, 10, 0xff0000));
			var img1:PsImage = new PsImage(new ColorAsset(10, 10, 0x00ff00));
			
			tf.autoSize = 'left';
			tf.multiline = false;
			tf.wordWrap = false;
			tf.text = text;
			img0.y = img1.y = (tf.height - img0.height) / 2;
			tf.x = img0.width;
			res.addChild(tf);
			res.addViewElement(img0, 'img0');
			res.addViewElement(img1, 'img1');
			res.setViewHandler(ButtonPhaze.ACTIVE, onActive);
			res.setViewHandler(ButtonPhaze.DEFAULT, onDefault);
			return res;
		}
		private	function onActive(params:Object):void
		{
			params.img0.alpha = 0;
			params.img1.alpha = 1;
		}
		private	function onDefault(params:Object):void
		{
			params.img0.alpha = 1;
			params.img1.alpha = 0;
		}
	}

}