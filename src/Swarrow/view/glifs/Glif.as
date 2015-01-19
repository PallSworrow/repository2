package Swarrow.view.glifs 
{
	import PS.model.BaseSprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class Glif extends BaseSprite 
	{
		protected var _height:Number=150;
		protected var _width:Number=300;
		protected var trueWidth:Boolean = false;
		protected var trueHeight:Boolean = true;
		public function Glif() 
		{
			super();
			
		}
		override public function get width():Number 
		{
			if(trueWidth)
			return super.width;
			else 
			return _width;
			
		}
		override public function get height():Number 
		{
			if(trueHeight)
			return super.height;
			else
			return _height;
		}
		
		override public function set height(value:Number):void 
		{
			if(trueHeight)
			super.height = value;
			else 
			_height = value;
			
			onHeightSet();
			
		}
		
		override public function set width(value:Number):void 
		{
			if(trueWidth)
			super.width = value;
			else
			_width = value;
			
			onWidthSet();
			
			
		}
		protected function onWidthSet():void
		{
			dispatchWidthChange();
		}
		protected function onHeightSet():void
		{
			dispatchHeightChange();
		}
		
		protected function dispatchHeightChange():void
		{
			dispatchEvent(new GlifEvent(GlifEvent.HEIGHT_CHANGE));
			dispatchEvent(new GlifEvent(GlifEvent.SIZE_CHANGE));
		}
		protected function dispatchWidthChange():void
		{
			dispatchEvent(new GlifEvent(GlifEvent.WIDTH_CHANGE));
			dispatchEvent(new GlifEvent(GlifEvent.SIZE_CHANGE));
		}
	}

}