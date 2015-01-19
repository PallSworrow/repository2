package view.elements.pageModules {
	import flash.events.Event;
	import flash.geom.Rectangle;
	import PS.model.BaseSprite;
	import PS.view.previewer.bases.SimplePreview;
	import PS.view.previewer.FitTheSize;
	import Swarrow.tools.dataObservers.ArrayObserver;
	import Swarrow.tools.dataObservers.events.ArrayObserverEvent;
	import Swarrow.view.glifs.Glif;
	
	/**
	 * ...
	 * @author 
	 */
	public class Photo3Module extends Glif 
	{
		private var prev0:SimplePreview;
		private var prev1:SimplePreview;
		private var prev2:SimplePreview;
		private var interval:int = 8;
		private var manager:ArrayObserver;
		private var list:Array;
		public function Photo3Module(listProvider:ArrayObserver, editable:Boolean = false) 
		{
			super();
			trueHeight = false;
			manager = listProvider;
			prev0 = createPreview(100,100);
			prev1 = createPreview(100,100);
			prev2 = createPreview(100,100);
		
			
			addChild(prev0);
			addChild(prev1);
			addChild(prev2);
			onWidthSet();
			
			manager.addEventListener(ArrayObserverEvent.UPDATE, manager_update);
			manager_update();
		}
		
		private function manager_update(e:ArrayObserverEvent = null ):void 
		{
			trace('manager_update ' + prev0.width);
			for (var i:int = 0; i < 3; i++) 
			{
				this['prev' + i].load(String(manager.getItem(i)));
			}
		}
		override public function get height():Number 
		{
			return width * 0.6;
		}
		
		override public function set height(value:Number):void 
		{
			
		}
		override protected function onWidthSet():void 
		{
			trace('onWidthSet ' + width);
			super.onWidthSet();
			prev0.width = width * 0.62;
			prev1.width = prev2.width = width * 0.36;
			
			prev0.height = height;
			prev1.height = prev2.height = height * 0.49;
			
			prev1.x = prev2.x = width * 0.64;
			prev2.y = height * 0.51;
			dispatchHeightChange();
		}
		
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			try
			{
				//trace(this, '!!!!!!!!!!!!!!!');
				prev0.load(String(manager.getItem(0)));
				prev1.load(String(manager.getItem(1)));
				prev2.load(String(manager.getItem(2)));
			}
			catch(e:Error){}
		}
		private function createPreview(w:int, h:int):SimplePreview
		{
			var res:SimplePreview = new SimplePreview(w, h);
			res.ftsType = FitTheSize.FULL;
			return res;
		}
		
	}

}