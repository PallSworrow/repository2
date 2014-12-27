package PS.view.button.groupBehaviors {
	import PS.view.button.ButtonPhaze;
	import PS.view.button.interfaces.IbtnGroupBehavior;
	import PS.view.button.PsButton;
	
	/**
	 * ...
	 * @author 
	 */
	public class DefaultSwitchBehavior implements IbtnGroupBehavior 
	{
		private var list:Vector.<PsButton>;
		public function DefaultSwitchBehavior() 
		{
			
		}
		
		/* INTERFACE PS_starling.view.button.interfaces.IbuttonGroupBehavior */
		
		public function tap(index:int):void 
		{
			var btn:PsButton;
			for (var i:int = list.length - 1; i >= 0; i--)
			{
				btn = list[i];
				if (index == i) btn.setPhaze(ButtonPhaze.ACTIVE);
				else btn.setPhaze(ButtonPhaze.DEFAULT);
			}
		}
		
		public function init(btnList:Vector.<PsButton>):void 
		{
			list = btnList;
		}
		
		public function dispose():void 
		{
			list = null;
		}
		
	}

}