package view.factories.btns {
	import model.Embeds;
	import PS.model.dataProcessing.assetManager.EmbedAsset;
	import PS.model.dataProcessing.assetManager.Iasset;
	import PS.model.PsImage;
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
	public class CheckBoxFactory implements IbuttonFactory 
	{
		private static const asset0:Iasset = new EmbedAsset(Embeds.check_0);
		private static const asset1:Iasset = new EmbedAsset(Embeds.check_1);
		public function CheckBoxFactory() 
		{
			
		}
		
		/* INTERFACE PS.view.factories.interfaces.IbuttonFactory */
		public static const inst:IbuttonFactory = new CheckBoxFactory();
		public function createButton(text:String):Ibtn 
		{
			var res:PsButton = new PsButton();
			var img0:PsImage = new PsImage(asset0);
			var img1:PsImage = new PsImage(asset1);
			var tf:SimpleText = SimpleTextFactory.inst.createText();
			
			tf.autoSize = 'left';
			tf.multiline = false;
			tf.wordWrap = false;
			tf.text = text;
			tf.x = img0.width;
			res.addChild(tf);
			res.addViewElement(img0, 'img0');
			res.addViewElement(img1, 'img1');
			
			res.setViewHandler(ButtonPhaze.DEFAULT, onDefault);
			res.setViewHandler(ButtonPhaze.ACTIVE, onActive);
			
			return res;
		}
		
		private function onDefault(params:Object):void
		{
			params.img0.alpha = 1;
			params.img1.alpha = 0;
		}
		private function onActive(params:Object):void
		{
			params.img0.alpha = 0;
			params.img1.alpha = 1;
		}
		
	}

}