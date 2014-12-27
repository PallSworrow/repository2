package PS.view.scroller.pages 
{
	import flash.display.DisplayObject;
	import flash.text.TextField;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.dataProcessing.assetManager.Iasset;
	import PS.model.interfaces.IviewElement;
	import PS.model.PsImage;
	/**
	 * ...
	 * @author 
	 */
	public class TestPage extends EmptyPage 
	{
		private var W:int;
		private var H:int;
		private var asset:Iasset;
		public function TestPage(w:int,h:int) 
		{
			super();
			W = w;
			H = h;
			asset = new ColorAsset(w, h);
		}
		private var tf:TextField;
		override public function load():void 
		{
			if (isLoaded) return;
			super.load();
			tf = new TextField();
			tf.width = W;
			tf.wordWrap = true;
			addChild(new PsImage(asset));
			for (var prop:String in currentData)
			{
				tf.appendText(prop + ': ' + currentData[prop]);
			}
			addChild(tf);
		}
		override public function clear():void 
		{
			if (!isLoaded) return;
			removeChildren();
			tf = null;
			super.clear();
		}
	}

}