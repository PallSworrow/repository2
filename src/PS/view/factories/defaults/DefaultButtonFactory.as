package PS.view.factories.defaults {
	import adobe.utils.CustomActions;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import mx.core.IAssetLayoutFeatures;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.dataProcessing.assetManager.Iasset;
	import PS.model.PsImage;
	import PS.view.button.ButtonPhaze;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.button.PsButton;
	import PS.view.factories.interfaces.IbuttonFactory;
	
	/**
	 * ...
	 * @author 
	 */
	public class DefaultButtonFactory implements IbuttonFactory 
	{
		
		public static function createBtn(text:String):Ibtn
		{
			return inst.createButton(text);
		}
		
		private static var _inst:DefaultButtonFactory;
		
		
		private var asset:Iasset;
		public function DefaultButtonFactory(color:uint=0) 
		{
			asset = new ColorAsset(100, 100, color)
		}
		
		/* INTERFACE PS.view.factories.IbuttonFactory */
		public function createButton(text:String):Ibtn 
		{
			var res:PsButton = new PsButton();
			var tf:TextField;
			var bg:PsImage = new PsImage(asset);
			tf = new TextField();
			tf.height = 30;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.text = text;
			tf.selectable = false;
			tf.border = true;
			
			bg.width = tf.width;
			bg.height = tf.height;
			
			res.addChild(bg);
			res.addChild(tf);
			
			res.setViewHandler(ButtonPhaze.DEFAULT, onDefault);
			res.setViewHandler(ButtonPhaze.ACTIVE, onActive);
			return res;
		}
		
		private function onActive(elts:Object):void 
		{
			elts.root.alpha = 1;
		}
		
		private function onDefault(elts:Object):void 
		{
			elts.root.alpha = 0.4;
		}
		
		static public function get inst():DefaultButtonFactory 
		{
			if (!_inst) _inst = new DefaultButtonFactory();
			return _inst;
		}
		
	}

}