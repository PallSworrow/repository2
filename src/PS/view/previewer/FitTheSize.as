package PS.view.previewer 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author p.swarrow
	 */
	public class FitTheSize 
	{
		//METHODS:
		public static const BY_LARGER_SIDE:String = 'byLargerSide';
		public static const BY_SMALLER_SIDE:String = 'bySmallerSide';
		
		public static const FILL:String = 'fill';
		public static const FULL:String = 'full';
		public static const SCALE:String = 'scale';
		
		
		//REALISATIONS:
		public static function fts(type:String, item:DisplayObject, w:int, h:int):void
		{
			var sx:Number = w / item.width;
			var sy:Number = h / item.height;
			switch(type)
			{
				case BY_LARGER_SIDE:
					ftsByLargerSide(item, w, h);
					break;
					
				case BY_SMALLER_SIDE:
					ftsBySmallerSide(item, w, h);
					break;
					
				case FULL:
					if (sx > sy)
					ftsByLargerSide(item, w, h);
					else     
					ftsBySmallerSide(item, w, h);
					break;
					
				case FILL:
					if (sx < sy)
					ftsByLargerSide(item, w, h);
					else     
					ftsBySmallerSide(item, w, h);
					break;
					
				case SCALE:
					ftsByScalling(item, w, h);
					break;
					
				default:
					throw new Error('Не поддерживаемый FTS тип: ' + type); 
					break;
			}
		}
		
		static public function ftsBySmallerSide(item:DisplayObject, w:int, h:int):void 
		{
			
			var scale:Number;
			
			if (item.width < item.height)
			{
				item.width = w;
				item.scaleY = item.scaleX;
			}
			else
			{
				item.height = h;
				item.scaleX = item.scaleY;
			}
			
		}
		
		static public function ftsByLargerSide(item:DisplayObject, w:int, h:int):void 
		{
			var scale:Number;
			
			if (item.width > item.height)
			{
				item.width = w;
				item.scaleY = item.scaleX;
			}
			else
			{
				item.height = h;
				item.scaleX = item.scaleY;
			}
		}
		
		
		
		public static function ftsByScalling(item:DisplayObject, w:int, h:int):void
		{
			
			item.width  = w;
			item.height = h;
		}
		
		
	}

}