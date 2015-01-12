package view.elements 
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	import PS.model.BaseSprite;
	import PS.view.previewer.bases.SimplePreview;
	import PS.view.previewer.FitTheSize;
	import Swarrow.tools.dataObservers.ArrayObserver;
	
	/**
	 * ...
	 * @author 
	 */
	public class Photo3Module extends BaseSprite 
	{
		private var prev0:SimplePreview;
		private var prev1:SimplePreview;
		private var prev2:SimplePreview;
		private var interval:int = 8;
		private var manager:ArrayObserver;
		private var list:Array;
		public function Photo3Module(rectangle:Rectangle, listProvider:ArrayObserver, editable:Boolean = false) 
		{
			super();
			trace(this, rectangle);
			manager = listProvider;
			prev0 = createPreview(3 * rectangle.width / 4 - interval, rectangle.height);
			prev1 = createPreview(rectangle.width / 4, rectangle.height / 2 - interval / 2);
			prev2 = createPreview(rectangle.width / 4, rectangle.height / 2 - interval / 2);
			
			prev1.x = prev2.x = prev0.x +prev0.width + interval;
			prev2.y = rectangle.height / 2 + interval / 2;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			addChild(prev0);
			addChild(prev1);
			addChild(prev2);
			
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