package PS.view.screenSystem 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import PS.model.interfaces.IviewElement;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.layouts.implementations.tagTyped.SimpleTagLayout;
	import PS.view.layouts.interfaces.ItagLayout;
	/**
	 * ...
	 * @author 
	 */
	public class ScreenBase implements Iscreen 
	{
		protected static const ScreenWidth:int = 800;
		protected static const ScreenHeight:int = 600;
		private var m:IscreenManager;
		private var layout:SimpleTagLayout;
		private var dispatcher:EventDispatcher;
		public function ScreenBase(manager:IscreenManager) 
		{
			m = manager;
			dispatcher = new EventDispatcher();
		}
		//PROTECTED: ------------------------------------------------------------------------
		protected function dispatchEvent(event:Event):void
		{
			dispatcher.dispatchEvent(event);
		}
		protected function addItem(item:IviewElement, tag:String=null):void
		{
			if (!layout) throw new Error('Error. you can not add elements untill screen would be shown');
			
			layout.addItem(item, tag);
		}
		protected function removeItem(item:IviewElement):void
		{
			if (!layout) throw new Error('Error. you can not remove elements untill screen would be shown');
			layout.removeItem(item);
		}
		protected function removeByTag(tag:String):void
		{
			if (!layout) throw new Error('Error. you can not remove elements untill screen would be shown');
			layout.removeByTag(tag);
		}
		protected function getItem(tag:String):IviewElement
		{
			if (!layout) throw new Error('Error. you can not get elements untill screen would be shown');
			return layout.getItem(tag);
		}
		protected function placeMethod(item:IviewElement,tag:String):void
		{
			
		}
		protected function goto(location:Object, data:Object=null):void
		{
			m.navigateTo(location, data);
		}
		
		//====================================================================================
		
		// INTERFACE PS.view.screenSystem.Iscreen -------------------------------------------
		
		public function show():void 
		{
			layout = new SimpleTagLayout(new Rectangle(0,0,800,600));
			layout.placeMethod = placeMethod;
			m.conatiner.addChild(layout);
		}
		
		public function hide():void 
		{
			layout.dispose();
			layout = null;
		}
		
		public function load(data:Object):void 
		{
			
		}
		
		public function clear():void 
		{
			
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		//==============================================================================================
	}

}