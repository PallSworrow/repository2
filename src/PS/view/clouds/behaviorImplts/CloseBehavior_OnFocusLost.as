package PS.view.clouds.behaviorImplts {
	import adobe.utils.CustomActions;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.FocusEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import PS.view.clouds.CloudWindow;
	import PS.view.clouds.interfaces.IcloudWindow;
	import PS.view.clouds.interfaces.ICWcloseBehavior;
	/**
	 * ...
	 * @author 
	 */
	public class CloseBehavior_OnFocusLost extends CWbehaviorBase implements ICWcloseBehavior
	{
		
		public function CloseBehavior_OnFocusLost() 
		{
			
		}
		private var _focus:int = 0;
		private var focusLostTimer:uint;
		override public function init(target:CloudWindow, stage:Stage, trigger:InteractiveObject):void 
		{
			if (!(target.item is InteractiveObject)) throw new Error('window.item must be an interactiveObject for this behavior');
			super.init(target, stage, trigger);
		}
		override protected function enable():void 
		{
			super.enable();
			
			_focus = 0;
			if (currentTrigger.parent.stage.focus == currentTrigger) focus++;
			if (currentStage.focus == currenTarget.item) focus++;
			
			trace(this, 'start: ' + focus);
			currentTrigger.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			currenTarget.item.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			
			currentTrigger.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
			currenTarget.item.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
		}
		
	
		private function focusIn(e:FocusEvent):void
		{
			focus++;
			trace(this, e.target, 'focusIn: ' + focus);
		}
		private function focusOut(e:FocusEvent):void 
		{
			focus--;
			trace(this, e.target, 'focusOut: ' + focus);
			
		}
		override protected function disable():void 
		{
			
			clearTimeout(focusLostTimer);
			currentTrigger.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			currenTarget.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			currentTrigger.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			currenTarget.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			super.disable();
		}
		
		public function get focus():int 
		{
			return _focus;
		}
		
		public function set focus(value:int):void 
		{
			_focus = value;
			if (value <= 0 && !focusLostTimer)
			{
				focusLostTimer = setTimeout(onFocusLost, 200);
			}
			if (value > 0 && focusLostTimer)
			{
				clearTimeout(focusLostTimer);
				focusLostTimer = null;
			}
		}
		
		private function onFocusLost():void 
		{
			clearTimeout(focusLostTimer);
			focusLostTimer = null;
			currenTarget.hide();
		}
		
	}

}