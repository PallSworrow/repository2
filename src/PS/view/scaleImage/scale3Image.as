package PS.view.scaleImage 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import PS.model.dataProcessing.assetManager.Iasset;
	import PS.model.PsImage;
	
	/**
	 * ...
	 * @author 
	 */
	public class scale3Image extends Sprite 
	{
		private var _asset:Iasset;
		private var data:BitmapData;
		private var _vertical:Boolean ;
		private var img0:Bitmap;
		private var img1:Bitmap;
		private var img2:Bitmap;
		public function scale3Image(asset:Iasset, fromStart:int,fromEnd:int, verticaly:Boolean = true) 
		{
			_vertical = verticaly;
			super();
			data = asset.getBitmap();
			var subData:BitmapData 
			
			if (_vertical)
			{
				subData = new BitmapData(data.width, fromStart, true, 0);
				subData.copyPixels(data,new Rectangle(0,0,data.width,fromStart),new Point());
				img0 = new Bitmap(subData);
				
				subData = new BitmapData(data.width, data.height - fromStart-fromEnd, true, 0);
				subData.draw(data,new Matrix(1,0,0,1,0,-fromStart));
				img1 = new Bitmap(subData);
				img1.y = img0.height;
				
				subData = new BitmapData(data.width, data.height - img0.height-img1.height, true, 0);
				subData.draw(data, new Matrix(1,0,0,1,0,-fromStart-img1.height ));
				img2 = new Bitmap(subData);
				img2.y = img1.y + img1.height;
				
			}
			else
			{
				subData = new BitmapData(fromStart,data.height, true, 0);
				subData.draw(data);
				img0 = new Bitmap(subData);
				
				subData = new BitmapData(data.width - fromStart-fromEnd, data.height, true, 0);
				subData.draw(data,new Matrix(1,0,0,1,-fromStart));
				img1 = new Bitmap(subData);
				img1.x = img0.width;
				
				subData = new BitmapData(data.width - img0.width-img1.width, data.height, true, 0);
				subData.draw(data, new Matrix(1,0,0,1,-fromStart-img1.width ));
				img2 = new Bitmap(subData);
				img2.x = img1.x + img1.width;
			}
			addChild(img0);
			addChild(img1);
			addChild(img2);
			
			//addChild(new Bitmap(data));
			
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
			data = null;
			
		}
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			if (!_vertical)
			{
				 value -= img0.width + img2.width;
				if (value < 0) value = 0;
				img1.width = value+1;
				img2.x = img1.x + img1.width-1;
				
			}
			else
			super.width = value;
		}
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			if (_vertical)
			{
				 value -= img0.height + img2.height;
				if (value < 0) value = 0;
				img1.height = value+1;
				img2.y = img1.y + img1.height-1;
				
			}
			else
			super.height = value;
		}
		
		public function get vertical():Boolean 
		{
			return _vertical;
		}
	}

}