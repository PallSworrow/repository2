package PS.view.clouds.behaviorImplts 
{
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import PS.view.clouds.CloudWindow;
	import PS.view.clouds.interfaces.ICWopenBehavior;
	/**
	 * ...
	 * @author 
	 */
	public class OpenBehavior_OnTap extends CWbehaviorBase implements ICWopenBehavior
	{
		
		public function OpenBehavior_OnTap() 
		{
			
		}
		
		
		
		
		
		override protected function enable():void 
		{
			currentTrigger.addEventListener(MouseEvent.CLICK, trig_click);
		}
		override protected function disable():void 
		{
			currentTrigger.removeEventListener(MouseEvent.CLICK, trig_click);
		}
		
		private function trig_click(e:MouseEvent):void 
		{
			currenTarget.show();
		}
		
		
		
	}

}