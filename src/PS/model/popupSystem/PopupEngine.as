package PS.model.popupSystem {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import PS.model.Globals;
	/**
	 * ...
	 * @author 
	 */
	public class PopupEngine 
	{
		private static var _container:DisplayObjectContainer;
		
		private static const stack:Vector.<Popup> = new Vector.<Popup>;
		private static var curr:Popup;
		
		public static var FogColor:uint = 0x000000;
		public static var FogAlpha:Number = 0.7;
		private static var fog:Shape;
		//fogging:
		private static function createFog():void
		{
			if (!fog)
			{
				fog = new Shape();
				fog.graphics.beginFill(FogColor, FogAlpha);
				fog.graphics.drawRect(0, 0, Globals.Width, Globals.Height);
				fog.graphics.endFill();
				container.addChild(fog);
			}
		}
		private static function removeFog():void
		{
			if (fog)
			{
				container.removeChild(fog);
				fog = null;
			}
		}
		
		
		internal static function addPopup(pp:Popup):void
		{
			if (curr)
			{
				stack.push(pp);
			}
			else
			{
				showPopup(pp);
			}
			
		}
		private static function showPopup(pp:Popup):void
		{
			curr = pp;
			createFog();
			pp.addTo(container);
		}
		internal static function closePopup(pp:Popup):void
		{
			
			if (!pp)return;//error
			
			if (pp == curr)
			{
				pp.remove(container);
				curr = null;
				if (stack.length > 0) showPopup(stack.shift());
			}
			else if(stack.indexOf(pp) >=0)
			{
				stack.splice(stack.indexOf(pp), 1);
			}
			else
			{
				//no popup found
			}
			if (!curr) removeFog();
		}
		
		
		
		//PUBLIC STATIC INTERACTION:
		public static function closeAll():void
		{
			stack.splice(0, stack.length);
			if (curr) closePopup(curr);
		}
		public static function closeCurrent():void
		{
			closePopup(curr);
		}
		static public function get container():DisplayObjectContainer 
		{
			return _container;
		}
		
		static public function set container(value:DisplayObjectContainer):void 
		{
			_container = value;
		}
		 
		
	}

}