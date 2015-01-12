package view.elements.pageModules.factories 
{
	import flash.geom.Rectangle;
	import PS.model.interfaces.IviewElement;
	import Swarrow.tools.dataObservers.IntegerObserver;
	import view.elements.Photo3Module;
	/**
	 * ...
	 * @author pall
	 */
	public class PhotosFactory extends GlifFactory 
	{
		
		public function PhotosFactory(params:Object=null) 
		{
			super(params);
			
		}
		override protected function creator(params:Object):IviewElement 
		{
			var rectangle:Rectangle;
			if (params.width is IntegerObserver) params.width = params.width.currentValue;
			rectangle = new Rectangle(0, 0, params.width, params.width * 0.6);
			return new Photo3Module(rectangle, params.manager, params.editable);
		}
	}

}