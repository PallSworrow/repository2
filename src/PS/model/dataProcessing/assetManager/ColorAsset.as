package PS.model.dataProcessing.assetManager 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author 
	 */
	public class ColorAsset implements Iasset 
	{
		
		public function ColorAsset(width:int,height:int,fill:uint=0) 
		{
			if (fill == 0)
			{
				fill = Math.random() * 0xffffff;
			}
			 color = fill + 0xff000000;
		
			w = width;
			h = height;
		}
		
		private var adds:int = 0;
		private var data:BitmapData;
		
		private var color:uint;
		private var w:int;
		private var h:int;
		
		/* INTERFACE PS.model.dataProcessing.assetManager.Iasset */
	
		public function getBitmap():BitmapData
		{
			adds++;
			if (!data)
			{
				data = new BitmapData(w, h,true,color);
			}
			return data;
		}
		
		public function killBitmap():void 
		{
			if (adds > 0) adds--;
			if (adds == 0 && data)
			{
				data.dispose();
				data = null;
			}
		}
		
	}

}