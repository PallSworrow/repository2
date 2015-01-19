package view.elements.pageModules.factories 
{
	import flash.geom.Rectangle;
	import PS.model.interfaces.IviewElement;
	import Swarrow.tools.dataObservers.IntegerObserver;
	import view.elements.pageModules.Photo3Module;
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
			return new Photo3Module(params.manager, params.editable);
		}
	}

}