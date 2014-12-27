package PS.model.requestSystem.implementers 
{
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import PS.model.requestSystem.RequestImplementer;
	/**
	 * ...
	 * @author 
	 */
	public class RandomAnswer extends RequestImplementer 
	{
		
		public function RandomAnswer() 
		{
			super();
			
		}
		private var timer:uint;
		override protected function call(params:Object):void 
		{
			super.call(params);
			trace(this + ': CAll');
			timer = setTimeout(desision,1000);
			
		}
		override protected function pause():void 
		{
			if(timer) clearTimeout(timer);
			super.pause();
		}
		override protected function resume():void 
		{
			timer = setTimeout(desision,1000);
			super.resume();
		}
		override protected function abort():void 
		{
			if (timer) clearTimeout(timer);
			timer = null;
			super.abort();
		}
		private function desision():void
		{
			if (Math.random() > 0.5) solve(true, { } );
			else solve(false, { } );
		}
		////////////////////////////////////////////////////
		
		override public function dispose():void 
		{
			if (timer) clearTimeout(timer);
			timer = null;
			super.dispose();
		}
		
		
	}

}