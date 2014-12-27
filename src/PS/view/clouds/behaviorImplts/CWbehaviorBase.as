package PS.view.clouds.behaviorImplts 
{
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import PS.view.clouds.CloudWindow;
	import PS.view.clouds.interfaces.ICWcloseBehavior;
	/**
	 * ...
	 * @author 
	 */
	public class CWbehaviorBase
	{
		private var _enabled:Boolean = false;
		
		public function CWbehaviorBase() 
		{
			
		}
		
		/* INTERFACE PS.view.clouds.interfaces.ICWcloseBehavior */
		protected var currentStage:Stage;
		protected var currentTrigger:InteractiveObject;
		protected var currenTarget:CloudWindow;
		public function init(target:CloudWindow, stage:Stage, trigger:InteractiveObject):void 
		{
			currenTarget = target;
			currentStage = stage;
			currentTrigger = trigger;
		}
		
		public function dispose():void 
		{
			enabled = false;
			currenTarget = null;
			currentStage = null;
			currentTrigger = null;
		}
		
		public function set enabled(value:Boolean):void 
		{
			if (_enabled == value) return;
			_enabled = value;
			
			if (value) enable();
			else disable();
		}
		
		public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		protected function enable():void
		{
			
		}
		protected function disable():void
		{
			
		}
		
	}

}