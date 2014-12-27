package PS.model.popupSystem 
{
	//import PS.model.popupSystem.popups.GalleryPopup;
	import PS.model.popupSystem.popups.PopupType;
	/**
	 * ...
	 * @author 
	 */
	public class PopupManager 
	{
		private static var popups:Object = { };
		private static var factories:Object = { };
		public static function getPopup(type:String, requiredInterface:Class=null):Ipopup
		{
			if (!popups[type])
			{
				if (factories[type]) popups[type] = (factories[type] as IpopupFactory).createPopup();
				else
				{
					//check defaults:
					switch(type)
					{
						/*case PopupType.GALLERY:
							popups[type] = new GalleryPopup();
							break;*/
						
						default:
							throw new Error('This popup up type do not supported. type:' + type);
							break;
					}
					
				}
			}
			if (requiredInterface) if (!(popups[type] is requiredInterface)) throw new Error('Popup does not implements required interface. popup:'+popups[type]+' req type: '+requiredInterface); 
			return popups[type] as Ipopup;
		}
		public static function showPopup(type:String, parameters:Object = null):void
		{
			getPopup(type).show(parameters);
		}
		public static function closePopup(type:String, parameters:Object = null):void
		{
			getPopup(type).close(parameters);
		}
		public static function disposePopup(type:String):void
		{
			trace('dispose: '+type);
			if (!popups[type])
			{
				trace('doesnt exist');
				return;
			}
			trace('close');
			if ((popups[type] as Ipopup).isShown)(popups[type] as Popup).close();
			popups[type] = null;
		}
		public static function setPopupFactory(popupType:String, factory:IpopupFactory):void
		{
			disposePopup(popupType);
			factories[popupType] = factory;
			
		}
		
	}

}