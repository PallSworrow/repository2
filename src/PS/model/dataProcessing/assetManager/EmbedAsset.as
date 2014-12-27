package PS.model.dataProcessing.assetManager {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author 
	 */
	public class EmbedAsset implements Iasset 
	{
		private var adds:int = 0;
		private var data:Bitmap
		private var emb:Class;
		public function EmbedAsset(source:Class) 
		{
			emb = source;
		}
		
		/* INTERFACE PS.model.dataProcessing.assetManager.Iasset */
	
		public function getBitmap():BitmapData
		{
			adds++;
			if (!data) 
			{
				data = new emb();
			}
			
			return data.bitmapData;
		}
		
		public function killBitmap():void 
		{
			if (adds > 0) adds--;
			if (adds == 0 && data)
			{
				data.bitmapData.dispose();
				data = null;
			}
		}
		
	}

}