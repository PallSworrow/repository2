package PS.view.layouts.implementations.listTyped 
{
	import flash.geom.Rectangle;
	import PS.model.interfaces.IviewElement;
	/**
	 * ...
	 * @author 
	 */
	public class StringListLayout_light extends SimpleListLayout 
	{
		private var _nunStrings:int = 0;
		private var _strinItemInterval:int = 0;
		private var _forcePageSize:int = 0;
		public function StringListLayout_light(rect:Rectangle) 
		{
			super();
			setRectangle(rect);
		}
		override public function addItemTo(item:IviewElement, index:int, forceSize:int = -1):void 
		{
			if (vertical && item.width > borderWidth) throw Error('Елемент больше заданного размера таблицы'+item.width+', '+borderWidth);
			if (!vertical && item.height > borderHeight) throw Error('Елемент больше заданного размера таблицы');
			
			super.addItemTo(item, index, forceSize);
		}
		private var pagesData:Array;
		override public function update():void 
		{
			var resSize:int = 0;
			var stringOffset:int = 0;//alt
			var columnOffset:int = 0;//main
			var item:ListPage;
			_nunStrings = 0;
			
			
			
			var altStep:int=0;
			var mainStep:int=0;
			var L:int = length;
			if (L > 0) _nunStrings = 1;
			else return;
										
				
				pagesData = [];
			var stringMaxSize:int = 0;
			for (var i:int = 0; i < L; i++)
			{
				item = list[i];
				item.vertical = vertical;

				if (stringOffset + item.altSize > altSize)
				{
					columnOffset += stringMaxSize+pagesInterval;
					stringMaxSize = 0;
					stringOffset = 0;
					_nunStrings ++;
				}
				
				if (stringMaxSize < item.size) stringMaxSize = item.size;
				
				
				
				
				pagesData[_nunStrings] = { };
				pagesData[_nunStrings].offset =columnOffset;
				pagesData[_nunStrings].size = stringMaxSize;
				
				
				item.offset = columnOffset;
				item.altOffset = stringOffset;
				
				resSize = item.offset + item.size;
				
				stringOffset = item.altOffset + item.altSize+stringItemInterval;
				
				
			}
			size = resSize;
			
			//super.update();
			/*var item:ListPage;
			
			var stringOffset:int = 0;
			size = 0;
			_nunStrings = 0;
			var currentPageSize:int=0;
			
			var step:int;
			var altStep:int;
			var offset:int = 0;
			pagesData = [];
			//trace(this+' update border width: '+altSize);
			var L:int = length;
			for (var i:int = 0; i < L; i++)
			{
				item = list[i];
				item.vertical = vertical;
				
				if (forcePageSize > 0) step = forcePageSize;
				else if(item.size > currentPageSize)  step = item.size;
				
				altStep = item.altSize + stringItemInterval;
				//trace('item altsize:' + item.altSize);
				if(stringOffset+altStep>altSize)//new string
				{
					_nunStrings++;
					stringOffset = 0;
					currentPageSize = 0;
					if (offset == 0) offset = step;
					else offset += step + pagesInterval;
					
					
					
				}
				
				pagesData[_nunStrings] = { };
				pagesData[_nunStrings].offset =offset;
				pagesData[_nunStrings].size = currentPageSize;
				
				
				if (offset > 0) item.offset = offset + pagesInterval+startPagePos;
				else item.offset = startPagePos;
				
				if (stringOffset > 0) item.altOffset = stringOffset + _strinItemInterval + startStringPos;
				else item.altOffset = startStringPos;
				
				stringOffset = item.altSize+item.altOffset;
				
				//trace('item.y: '+item.offset+' , item.x: '+item.altOffset);
				
				
				
			}
			size = offset;*/
		}
		
		//////////////////////////////////////////
		public function getPageOffset(index:int):int
		{
			return pagesData[index].offset as int;
		}
		public function getPageSize(index:int):int
		{
			return pagesData[index].size as int;
		}
		
		private function get altSize():int
		{
			if (vertical) return borderWidth;
			else return borderHeight;
		}
		protected function get startPagePos():int
		{
			if (vertical) return borderLeft;
			else return borderUpper;
		}
		protected function get startStringPos():int
		{
			if (!vertical) return borderLeft;
			else return borderUpper;
		}
		
		
		
		public function get stringItemInterval():int 
		{
			return _strinItemInterval;
		}
		
		public function set stringItemInterval(value:int):void 
		{
			_strinItemInterval = value;
		}
		
		public function get nunStrings():int 
		{
			return _nunStrings;
		}
		
		public function get forcePageSize():int 
		{
			return _forcePageSize;
		}
		
		public function set forcePageSize(value:int):void 
		{
			_forcePageSize = value;
		}
		
	}

}