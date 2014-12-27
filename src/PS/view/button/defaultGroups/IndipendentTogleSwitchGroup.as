package PS.view.button.defaultGroups 
{
	import PS.view.button.BtnGroup;
	import PS.view.button.ButtonPhaze;
	import PS.view.button.interfaces.IbtnGroupBehavior;
	import PS.view.button.PsButton;
	/**
	 * ...
	 * @author 
	 */
	public class IndipendentTogleSwitchGroup extends BtnGroup
	{
		
		public function IndipendentTogleSwitchGroup() 
		{
			super(BtnGroup.TOGLE_SWITCH);
		}
		override public function tapItem(btn:PsButton):void 
		{
			//trace(this + 'tap');
			if (btn.phaze == ButtonPhaze.ACTIVE) btn.setPhaze(ButtonPhaze.DEFAULT);
			else btn.setPhaze(ButtonPhaze.ACTIVE);
		}
		
		/*override public function addItem(item:PsButton):void 
		{
			if (item.group == _name) return;
			if (item.group) item.group = null;//remove from any group...
			//add:
			list.push(item);
			item._group = this;
		}
		override public function removeItem(item:PsButton):void 
		{
			//super.removeItem(item);
		}*/
		override public function tapByIndex(index:int):void 
		{
			//super.tapByIndex(index);
		}
		
		override public function get behavior():IbtnGroupBehavior 
		{
			return null;
		}
		
		override public function set behavior(value:IbtnGroupBehavior):void 
		{
			//super.behavior = value;
		}
		override public function dispose():void 
		{
			//super.dispose();
		}
		/*override public function removeItemByIndex(index:int):void 
		{
			//super.removeItemByIndex(index);
		}*/
	}

}