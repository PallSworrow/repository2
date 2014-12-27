package PS.view.factories.defaults 
{
	import PS.model.dataProcessing.assetManager.Iasset;
	import PS.model.dataProcessing.profiles.IimageProfile;
	import PS.model.PsImage;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.button.PsButton;
	import PS.view.factories.interfaces.IbuttonFactory;
	/**
	 * ...
	 * @author 
	 */
	public class SimpleBtnFactory implements IbuttonFactory
	{
		private var _asset:Iasset;
		public function SimpleBtnFactory(asset:Iasset) 
		{
			_asset = asset;
		}
		
		/* INTERFACE PS.view.factories.interfaces.IbuttonFactory */
		
		public function createButton(text:String):Ibtn 
		{
			var res:PsButton = new PsButton();
			res.addChild(new PsImage(_asset));
			return res;
		}
		
	}

}