package view.elements 
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	import PS.model.BaseSprite;
	import PS.view.previewer.bases.SimplePreview;
	import PS.view.previewer.FitTheSize;
	import Swarrow.tools.valueManagers.interfaces.IvecStringValueManager;
	
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
		private var manager:IvecStringValueManager;
		private var list:Vector.<String>;
		public function Photo3Module(rectangle:Rectangle, listProvider:IvecStringValueManager, editable:Boolean = false) 
		{
			super();
			manager = listProvider;
			prev0 = createPreview(3 * rectangle.width / 4 - interval, rectangle.height);
			prev1 = createPreview(rectangle.width / 4, rectangle.height / 2 - interval / 2);
			prev2 = createPreview(rectangle.width / 4, rectangle.height / 2 - interval / 2);
			
			prev1.x = prev2.x = prev0.x +prev0.width + interval;
			prev2.y = rectangle.height / 2 + interval / 2;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			list = manager.getValue();
			
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
				prev0.load(list[0]);
				prev1.load(list[1]);
				prev2.load(list[2]);
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