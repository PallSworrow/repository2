package view.factories.tags {
	import mx.core.IAssetLayoutFeatures;
	import PS.model.BaseSprite;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.dataProcessing.assetManager.Iasset;
	import PS.model.interfaces.IviewElement;
	import PS.model.PsImage;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.button.PsButton;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.textView.SimpleText;
	import view.factories.interfaces.ItagViewFactory;
	/**
	 * ...
	 * @author 
	 */
	public class TestTagFactory implements IbuttonFactory
	{
		private static const asset:Iasset = new ColorAsset(100, 100, 0x00aa00);
		public static function createTagView(value:String):IviewElement
		{
			return inst.createButton(value);
		}
		
		public static const inst:TestTagFactory = new TestTagFactory();
	
		public function TestTagFactory()
		{
			
		}
		
		/* INTERFACE PS.view.factories.interfaces.IbuttonFactory */
		
		public function createButton(text:String):Ibtn 
		{
			var res:PsButton = new PsButton();
			var tf:SimpleText = new SimpleText();
			tf.autoSize = 'left';
			tf.multiline = false;
			tf.wordWrap = false;
			tf.text = text;
			var bg:PsImage = new PsImage(asset);
			bg.width = tf.width;
			bg.height = tf.height;
			res.addChild(bg);
			res.addChild(tf);
			res.name = text;
			return res;
		}
	}

}