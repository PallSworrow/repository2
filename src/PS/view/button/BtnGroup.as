package PS.view.button {
	import PS.view.button.defaultGroups.IndipendentTogleSwitchGroup;
	import PS.view.button.interfaces.IbtnGroupBehavior;
	import PS.view.button.groupBehaviors.DefaultSwitchBehavior;
	/**
	 * ...
	 * @author 
	 */
	public class BtnGroup 
	{
		//CONST: 
		public static const TOGLE_SWITCH:String = 'togle_switch_behavior_group';
		
	//STATIC ACCESS:
		private static const _groups:Object = 
		{
			
		};
		
		public static function addToGroup(groupName:String, item:PsButton):void
		{
			var gr:BtnGroup;
			//if no group:
			
			//trace('add '+item+ ' to group: ' + groupName);
			if (!_groups[groupName]) 
			{
				if (groupName == TOGLE_SWITCH)_groups[groupName] = new IndipendentTogleSwitchGroup()
				else 
				_groups[groupName] = new BtnGroup(groupName);
			}
			//add:
			
			gr = _groups[groupName];
			gr.addItem(item);
			gr = null;
		}
		public static function removeFromGroup(item:PsButton):void
		{
			if (!item.group) return;
			var gr:BtnGroup = _groups[item.group];
			gr.removeItem(item);
			gr = null;
		}
		
		public static function tapGroupElement(group:String, element:int):void
		{
			
			if (!_groups[group])
			{
				// TODO - error no group with this name
			}
			else
			{
				_groups[group].tapByIndex(element);
			}
		}
		
		
	//INSTANSE LEVEL:
		private var _name:String;
		private var list:Vector.<PsButton> = new Vector.<PsButton>;
		
		private var _behavior:IbtnGroupBehavior;
		//create:
		public function BtnGroup(groupName:String, switchBehavior:IbtnGroupBehavior = null ) 
		{
			behavior = switchBehavior;
			
			if (_groups[groupName] || (groupName == TOGLE_SWITCH && !(this is IndipendentTogleSwitchGroup) ))
			{
				throw new Error('group name "' + groupName + '" is restricted or already reserved');
			}
			_name = groupName;
			_groups[_name] = this;
			
			
		}
		//destroy:
		public function dispose():void
		{
			list = null;
			delete _groups[_name];
			_name = null;
			
			if (behavior) behavior.dispose();
			behavior = null;
		}
		
		//add Elements:
		public function addItem(item:PsButton):void
		{
			if (item.group == _name) return;
			if (item.group) item.group = null;//remove from any group...
			//add:
			list.push(item);
			item._group = this;//internal access. avoiding static search of group(as throught group = value)
			
			
		}
		//removeElements:
		public function removeItem(item:PsButton):void
		{
			var index:int = list.indexOf(item);
			removeItemByIndex(index);
		}
		public function removeItemByIndex(index:int):void
		{
			if (index >= 0 && index < list.length)
			list.splice(index, 1);
		}
		/**
		 * Чистит лишь ссылки на объекты. Нулит list. 
		 * После вызова - группа удаляется из списка групп. 
		 */
		
		//interaction:
		public function tapItem(btn:PsButton):void
		{
			var index:int = list.indexOf(btn);
			if (index == -1)
			{
				// TODO - catch error button is not an element of this group!
			}
			else
			{
				tapByIndex(index);
			}
		}
		public function tapByIndex(index:int):void
		{
			//trace('GROUP: ' + name);
			//trace('tap by index: ' + index);
			behavior.tap(index);
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		
		
		public function get behavior():IbtnGroupBehavior 
		{
			return _behavior;
		}
		
		public function set behavior(value:IbtnGroupBehavior):void 
		{
			//trace('set behavior to: ' + value);
			if (value == _behavior && _behavior != null) return;
			if (value == null) value = new DefaultSwitchBehavior();//never null
			
			if(_behavior)_behavior.dispose();
			_behavior = null;
			
			_behavior = value;
			_behavior.init(list);
			//trace('behaviort: ' + _behavior);
		}
		
		
		
		
	}

}