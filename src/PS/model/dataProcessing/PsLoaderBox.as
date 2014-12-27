package PS.model.dataProcessing 
{
	import flash.display.DisplayObject;
	import PS.constants.VarName;
	import PS.model.BaseSprite;
	import PS.model.requestSystem.interfaces.IrequestHandler;
	import PS.model.requestSystem.RequestManager;
	
	/**
	 * ...
	 * @author 
	 */
	public class PsLoaderBox extends BaseSprite 
	{
		
		
		private var _source:String;
		
		
		private var reqType:String;
		
		
		private var loadId:String;
		private var img:DisplayObject;
		public function PsLoaderBox(getImageRequestType:String) 
		{
			super();
			reqType = getImageRequestType;
		}
		
		public function get source():String 
		{
			return _source;
		}
		
		public function set source(value:String):void 
		{
			if (_source == value) return;
			clear();
			
			if (value == null || value == '') 
			{
				return;
			}
			
			loadId = RequestManager.ask(reqType, { link:value }, onLoad, onFail);
			_source = value;
		}
		
		private function onFail(param:Object):void 
		{
			loadId = null;
		}
		
		private function onLoad(param:Object):void 
		{
			img = param[VarName.DATA] as DisplayObject;
			addChild(img);
			loadId = null;
			trace(img);
		}
		private function clear():void
		{
			if (img)
			{
				removeChild(img);
				img = null;
			}
			if (loadId)
			{
				RequestManager.abort(reqType, loadId);
				loadId = null;
			}
			
		}
		override public function dispose():void 
		{
			clear();
			super.dispose();
		}
	}

}