package PS.model.popupSystem.popups {
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import PS.model.interfaces.IviewElement;
	import PS.model.popupSystem.Popup;
	import PS.view.layouts.implementations.tagTyped.SimpleTagLayout;
	import PS.view.layouts.interfaces.ItagLayout;
	
	/**
	 * ...
	 * @author 
	 */
	public class PopupExtended extends Popup 
	{
		
		private var layout:SimpleTagLayout;
		
		public function PopupExtended(rectangle:Rectangle) 
		{
			super();
			
			layout = new SimpleTagLayout(rectangle);
			layout.autoUpdate = false;
			layout.placeMethod = placeMethod;
		}
		override public function dispose():void 
		{
			if (layout) layout.dispose();
			layout = null;
			super.dispose();
		}
		//protected 
		protected function placeMethod(item:IviewElement, tag:String):void
		{
			
		}
		protected function addItem(item:IviewElement, tag:String):void
		{
			layout.addItem(item, tag);
		}
		protected function removeItem(tag:String):void
		{
			layout.removeByTag(tag);
		}
		override public function show(parameters:Object = null):void 
		{
			super.show(parameters);
			layout.update();
			layout.autoUpdate = true;
			addElement(layout)
		}
		override public function close(parameters:Object = null):void 
		{
			layout.autoUpdate = false;
			super.close(parameters);
		}
	}

}