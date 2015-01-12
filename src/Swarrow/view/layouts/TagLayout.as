package Swarrow.view.layouts 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import PS.model.BaseSprite;
	import PS.model.requestSystem.apiInteraction.vk.VkRequestHandler;
	import Swarrow.tools.dataObservers.IntegerObserver;
	/**
	 * ...
	 * @author pall
	 */
	public class TagLayout extends BaseSprite
	{
		public var placeMethod:Function;
		private var children:Dictionary;
		private var markers:Dictionary;
		private var observableMarkers:Array;
		public function TagLayout() 
		{
			children = new Dictionary();
			markers = new Dictionary();
			observableMarkers = [];
		}
		override public function dispose():void 
		{
			children = null;
			markers = null;
			for each(var prop:Object in observableMarkers)
			{
				prop.observer.removeListener(onMarkerUpdate);
			}
			observableMarkers = null;
			
			super.dispose();
		}
		//private 
		private function callUpdate():void
		{
			if (!placeMethod) return;
			
			switch(placeMethod.length)
			{
				case 0:
					placeMethod();
					break;
				case 1:
					placeMethod(children);
					break;
				case 2:
					placeMethod(children, markers);
					break;
				default:
					throw new Error('invalid paramams number: ' + placeMethod.length);
					break;
			}
			
		}
		private function onMarkerUpdate(e:Event)
		{
			var observer:IntegerObserver = e.target as IntegerObserver;
			var index:int = -1;
			var item:Object;
			for (var i:int = observableMarkers.length - 1; i >= 0;i--)
			{
				item = observableMarkers[i];
				if (item.observer == observer)
				{
					markers[item.name] = item.observer.currentValue;
					break;
				}
			}
			update();
		}
		
		//public
		public function addItem(child:DisplayObject, tag:String,forceUpdate:Boolean=true):void
		{
			children[tag] = child;
			addChild(child);
			if (forceUpdate) callUpdate();
		}
		public function addMarker(marker:Object, name:String):void
		{
			if (marker == null) 
			{
				removeMarker(name);
				return;
			}
			if (marker is Number) marker[name] = marker;
			else if (marker is IntegerObserver)
			{
				var observer:IntegerObserver = marker as IntegerObserver;
				observableMarkers.push({observer:observer, name:name});
				observer.addListener(onMarkerUpdate);
				markers[name] =  observer.currentValue;
			}
			else throw new Error('invalid marker type: ' + marker);
		}
		public function removeMarker(name:String):void
		{
			delete markers[name];
			var item:Object;
			for (var i:int = observableMarkers.length - 1; i >= 0;i--)
			{
		
				item = observableMarkers[i];
				if (item.name == name)
				{
					item.observer.removeListener(onMarkerUpdate);
					observableMarkers.splice(i, 1);
					break;
				}
			}
		}
		public function update():void
		{
			callUpdate();
		}
	}

}