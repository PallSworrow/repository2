package view.factories {
	import flash.display.DisplayObject;
	import model.constants.InstrumentType;
	import model.Embeds;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.dataProcessing.assetManager.EmbedAsset;
	import PS.model.interfaces.IviewElement;
	import PS.model.PsImage;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.button.PsButton;
	import PS.view.factories.interfaces.IbuttonFactory;
	import view.factories.interfaces.ItagViewFactory;
	/**
	 * ...
	 * @author 
	 */
	public class InstrumentIconFactory implements IbuttonFactory
	{
		private static var assets:Object;
		public static function createIcon(type:String):DisplayObject
		{
			if (!assets)
			{
				assets = { };
				assets[InstrumentType.GUITAR] = new EmbedAsset(Embeds.guitar);
				assets[InstrumentType.BASS_GUITAR] = new EmbedAsset(Embeds.bass);
				assets[InstrumentType.OTHER] = new EmbedAsset(Embeds.other);
				assets[InstrumentType.BAYANS] = new EmbedAsset(Embeds.bayans);
				assets[InstrumentType.ELECTRONIC] = new EmbedAsset(Embeds.electronic);
				assets[InstrumentType.KEYS] = new EmbedAsset(Embeds.keys);
				assets[InstrumentType.PERCUSSION] = new EmbedAsset(Embeds.drum);
				assets[InstrumentType.STRING] = new EmbedAsset(Embeds.string);
				assets[InstrumentType.VOCAL] = new EmbedAsset(Embeds.vocal);
				assets[InstrumentType.WIND] = new EmbedAsset(Embeds.wind);
			}
			if (type == 'guitar') type = InstrumentType.GUITAR;
			if (!assets[type]) throw new Error('invalid instrument type: ' + type);
			var res:PsImage = new PsImage(assets[type]);
			res.name = type;
			return res;
		}
		public static const inst:IbuttonFactory = new InstrumentIconFactory();
		public function InstrumentIconFactory ()
		{
			
		}
		
		
		public function createButton(text:String):Ibtn 
		{
			var res:PsButton = new PsButton();
			res.addChild(createIcon(text));
			res.name = text;
			return res;
		}
	}

}