package PS.view.gallery.interfaces 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import PS.model.interfaces.IviewElement;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IgalleryItem extends IviewElement
	{
		/**
		 * Инициализация объекта. Сохранение данных требуемых для методов load и enable
		 * @param	data
		 */
		function init(data:Object):void
		/**
		 * Метод обратный init().
		 * Полная очистка объекта.
		 */
		function kill():void
		
		/**
		 * Метод вызывается при отображении элемента в окне галереи или при придварительной загруке.
		 */
		function load():void
		/**
		 * Метод обратный load(). 
		 * при isEnabled=true вызывает метод disable().
		 */
		function clear():void
		
		/**
		 * Метод вызывается только при отображении элемента в окне галереи.
		 * И только после метода load(). При isLoaded=false - произойдет вызов load().
		 */
		function enable():void
		/**
		 * Метд обратный enable().
		 */
		function disable():void
		
		/**
		 * Определяет будет ли вызван метод load()  до того,как этот объект станет текущим в галерее.
		 * Размер стэка предварительной загрузки - определяется в галерее.
		 */
		function get needEarlyLoad():Boolean
		
		/**
		 *Был ли вызван метод load().
		 */
		function get isLoaded():Boolean
		/**
		 * Был ли вызван метод enable().
		 */
		function get isEnabled():Boolean
		
		/**
		 * Проверить нужно ли обработать тап по объекту. Если обработка не требуется - событие Tap перейдет к самой галерее
		 * @param	globalPoint - точка клика по экрану в глобальной системе координат
		 * @return true - объект сам обработает клик в этой точке экрана, false - объект "не интересует" эта точка.
		 */
		function isTapped(globalPoint:Point):Boolean
		
	}
	
}