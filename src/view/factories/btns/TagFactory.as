package view.factories.btns {
	import flash.display.Shape;
	import PS.model.dataProcessing.assetManager.Iasset;
	import PS.model.dataProcessing.assetManager.ShapeAsset;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.button.PsButton;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.scaleImage.scale3Image;
	import PS.view.textView.SimpleText;
	import view.constants.Fonts;
	
	/**
	 * ...
	 * @author
	 */
	public class TagFactory implements IbuttonFactory
	{
		private static const offset:int = 10;
		private var asset:Iasset
		public var showremoveBtn:Boolean = false;
		
		public function TagFactory(color:uint = 0)
		{
			if(color == 0) color = Math.random() * 0xffffff;
			asset = new ShapeAsset(shapeProvider);
			
			function shapeProvider():Shape
			{
				var res:Shape = new Shape();
				res.graphics.beginFill(color);
				res.graphics.drawRoundRectComplex(0, 0, 50, 30,3,3,3,3);
				res.graphics.endFill();
				return res;
			}
		
		
		}
		/* INTERFACE PS.view.factories.interfaces.IbuttonFactory */
		
		public function createButton(text:String):Ibtn
		{
			var res:PsButton = new PsButton();
			var img:scale3Image = new scale3Image(asset, offset, offset, false);
			var tf:SimpleText = new SimpleText();
			var btn:Shape;
			
			tf.defaultTextFormat = Fonts.TAGS;
			tf.autoSize = 'left';
			tf.multiline = false;
			tf.wordWrap = false;
			tf.text = text;
			tf.x = offset;
			tf.y = (img.height - tf.height ) / 2;
			img.width = tf.width + offset * 2;
			res.addChild(img);
			res.addChild(tf);
			if (showremoveBtn)
			{
				btn = new Shape();
				btn.graphics.lineStyle(1, 0);
				btn.graphics.lineTo(10, 10);
				btn.graphics.moveTo(0, 10);
				btn.graphics.lineTo(10, 0);
				res.addChild(btn);
				btn.x = tf.x + tf.width + 5;
				btn.y = (img.height - btn.height ) / 2;
				
				img.width += btn.width + 5;
				
			}
			
			return res;
		}
	
	}

}