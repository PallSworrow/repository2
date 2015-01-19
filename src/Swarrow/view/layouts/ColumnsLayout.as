package Swarrow.view.layouts 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import PS.model.BaseSprite;
	import PS.model.requestSystem.apiInteraction.vk.VkRequestHandler;
	import Swarrow.tools.dataObservers.IntegerObserver;
	import Swarrow.view.glifs.Glif;
	import Swarrow.view.glifs.GlifEvent;
	/**
	 * ...
	 * @author pall
	 */
	public class ColumnsLayout extends LayoutBase
	{
		
		
		public function ColumnsLayout(placeMethodArray:Array) 
		{
			children = new Dictionary();
			placeMethod = placeMethodArray;
		}
		private var _placeMethod:Array;
		private var interval:int = 0;
		
		private var dispatchFlag:Boolean = true;
		private var children:Dictionary;
		override protected function callUpdate(index:int=0):void 
		{
			var offset:int=0;
			var param:Object;
			var child:DisplayObject
			var padding:int;
			dispatchFlag = false;
			trace(this, 'callUpdate');
			for (var i:int = 0; i < numChildren; i++) 
			{
				child = getChildAt(i);
				padding = 0;
				if (placeMethod)
				{
					if (i < placeMethod.length)
					{
						param = checkParam(placeMethod[i]);
						if (param.width is Number &&(child is Glif || !ignorNonGlifs))
						{
							child.width = param.width as Number;
						}
						
						if (param.paddigLeft is Number) 
						offset += param.paddingRight as Number;
						
						if (param.paddigRight is Number) 
						padding = param.paddingRight as Number;
					}
					trace('param: ' + placeMethod[i]);
					trace('aplWidth: ' + param.width);
				}
				child.x = offset;
				
				offset = child.x + child.width+padding;
			}
			dispatchFlag = true;
			dispatchHeightChange();
		}
		private function checkParam(param:Object):Object
		{
			if (!param) return { };
			
			var aplWidth:Object;
			var paddingLeft:int;
			var paddingRight:int;
			if (param is Number || param is String) aplWidth = readNumber(param, width);
			else
			{
				if (param.width) aplWidth =readNumber(param.width, width);
				if (param.paddingLeft) paddingLeft =readNumber(param.paddingLeft, width);
				if (param.paddingRight) paddingRight =readNumber(param.paddingRight, width);
			}
			var res:Object =  { width:aplWidth, paddingLeft:paddingLeft, paddingRight:paddingRight };
			trace('retun: ' + res);
			return res;
			
			
			
		}
		private function readNumber(data:Object, appliement:int):int
		{
			var str:String;
			var def:String;
			var num:int;
			var res:int;
			switch(true)
			{
				case data is Number:
					res = data as Number;
					break;
				case data is String:
					str = String(data);
					def = str.substr( -1, 1);
					num = Number(str.substr(0, str.length - 1));
					if(!(num is Number))throw new Error('invalid param: ' + data);
					switch(def)
					{
						case '%':
							res = appliement * num / 100;
							break;
						case '-':
							res = appliement - num;
							break;
						default:
							throw new Error('invalid param: ' + data);
							break;
					}
					break;
				default:
					throw new Error('invalid param: ' + data);
					break;	
			}
			return res;
		}
		override protected function onWidthSet():void 
		{
			callUpdate();
		}
		override protected function onGlifHeightChange(e:GlifEvent):void 
		{
			if(dispatchFlag)
			dispatchHeightChange();
		}
		
		public function get placeMethod():Array 
		{
			return _placeMethod;
		}
		
		public function set placeMethod(value:Array):void 
		{
			_placeMethod = value;
			if(numChildren>0)
			callUpdate();
		}
	}

}