package PS.model.dataProcessing.assetManager 
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	/**
	 * ...
	 * @author 
	 */
	public class ShapeAsset implements Iasset 
	{
		private var provider:Function
		private var tex:BitmapData;
		private var adds:int = 0;
		public function ShapeAsset(shapeProvider:Function) 
		{
			provider = shapeProvider;
		}
		
		/* INTERFACE PS.model.dataProcessing.assetManager.Iasset */
		
		public function getBitmap():BitmapData 
		{
			if (!tex)
			{
				var shape:Shape = provider();
				tex = new BitmapData(shape.width, shape.height,true,0);
				tex.draw(shape);
				shape = null;
			}
			adds++;
			return tex;
		}
		
		public function killBitmap():void 
		{
			adds--;
			if (adds == 0)
			{
				tex.dispose();
				tex = null;
			}
		}
		
	}

}