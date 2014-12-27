package view.factories.tags {
	import mx.core.IAssetLayoutFeatures;
	import PS.model.BaseSprite;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.dataProcessing.assetManager.Iasset;
	import PS.model.interfaces.IviewElement;
	import PS.model.PsImage;
	import PS.view.textView.SimpleText;
	import view.factories.interfaces.ItagViewFactory;
	/**
	 * ...
	 * @author 
	 */
	public class TestTagFactory implements ItagViewFactory
	{
		private static const asset:Iasset = new ColorAsset(100, 100, 0x00aa00);
		public static function createTagView(value:String):IviewElement
		{
			return inst.createTag(value);
		}
		
		public static const inst:ItagViewFactory = new TestTagFactory();
	
		public function TestTagFactory()
		{
			
		}
		public function createTag(name:String):IviewElement 
		{
			var res:BaseSprite = new BaseSprite();
			var tf:SimpleText = new SimpleText();
			tf.autoSize = 'left';
			tf.multiline = false;
			tf.wordWrap = false;
			tf.text = name;
			var bg:PsImage = new PsImage(asset);
			bg.width = tf.width;
			bg.height = tf.height;
			res.addChild(bg);
			res.addChild(tf);
			res.name = name;
			return res;
		}
	}

}