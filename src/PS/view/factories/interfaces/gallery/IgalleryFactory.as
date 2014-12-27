package PS.view.factories.interfaces.gallery 
{
	import PS.view.gallery.interfaces.Igallery;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IgalleryFactory 
	{
		function createGallery(w:int, h:int,vertival:Boolean=false):Igallery
	}
	
}