package PS.model.requestSystem.implementers 
{
	import flash.events.Event;
	import PS.model.popupSystem.interfaces.IdialoguePopup;
	import PS.model.popupSystem.Popup;
	import PS.model.popupSystem.PopupEvent;
	import PS.model.popupSystem.PopupManager;
	import PS.model.requestSystem.RequestImplementer;
	
	/**
	 * ...
	 * @author 
	 */
	public class UserRequest extends RequestImplementer 
	{
		private var pp:IdialoguePopup;
		
		private var popupProvider:Function
		/**
		 * Всплыващее окно по указанному запросу должно исполнять интерфэйс IdialoguePopup
		 * @param	popupRequest
		 */
		private var popupReq:String;
		public function UserRequest(popupRequest:String) 
		{
			super();
			popupReq = popupRequest;
			
		}
		private function createPopup():IdialoguePopup
		{
			return PopupManager.getPopup(popupReq, IdialoguePopup) as IdialoguePopup;
		}
		override protected function call(params:Object):void 
		{
			pp = createPopup();
			pp.ask(onPositive, onNegative, params);
			super.call(params);
		}
		
		private function onNegative(params:Object=null):void 
		{
			solve(false, params);
		}
		
		private function onPositive(params:Object=null):void 
		{
			solve(true, params);
		}
		override protected function abort():void 
		{
			pp.forceAnswer(false, null);
			super.abort();
		}
		
	}

}