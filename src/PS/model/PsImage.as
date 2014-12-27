package PS.model 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import PS.model.dataProcessing.assetManager.Iasset;
	import PS.model.interfaces.Idisplayable;
	import PS.model.interfaces.Itransformable;
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public class PsImage extends Bitmap implements Itransformable 
	{
		private var _asset:Iasset
		public function PsImage(asset:Iasset) 
		{
			_asset = asset;
			super(_asset.getBitmap());
			smoothing = true;
			
		}
		
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
		}
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
		}
		/* INTERFACE PS.model.interfaces.Idisplayable */
		
		public function addTo(container:DisplayObjectContainer):void 
		{
			container.addChild(this);
		}
		
		public function remove():void 
		{
			if (parent) parent.removeChild(this);
		}
		
		public function dispose():void 
		{
			remove();
			_asset.killBitmap();
			_asset = null;
			bitmapData = null;
		}
		
	}

}