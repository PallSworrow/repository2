package PS.view.buttonMenus.implementations 
{
	import flash.display.DisplayObjectContainer;
	import PS.model.BaseSprite;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.buttonMenus.BtnMenuEvent;
	import PS.view.buttonMenus.IbuttonMenu;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.factories.interfaces.IlistLayoutFactory;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.layouts.interfaces.IlistLayout;
	
	/**
	 * ...
	 * @author 
	 */
	public class BtnListMenu extends BaseSprite implements IbuttonMenu 
	{
		
		private var buttons:Vector.<Ibtn>
		private var btnProvider:IbuttonFactory = new DefaultButtonFactory(0x234090);
		private var layoutProvider:Object;
		
		private var _btnNames:Vector.<String>;
		
		private var layout:IlistLayout;
		private var _handler:Function;
		public function BtnListMenu(names:Vector.<String> = null ) 
		{
			super();
			if (names) _btnNames = names;
			else _btnNames = new Vector.<String>;
			update();
			
		}
		
		/* INTERFACE PS.view.buttonMenus.IbuttonMenu */
		
		public function get btnNames():Vector.<String> 
		{
			return _btnNames;
		}
		
		public function set handler(value:Function):void 
		{
			_handler = value;
		}
		
		public function setLayoutProvider(value:Object, forceUpdate:Boolean = true):void 
		{
			layoutProvider = value;
			if (forceUpdate) update();
		}
		
		public function setBtnProvider(provider:IbuttonFactory, forceUpdate:Boolean = true):void 
		{
			btnProvider = provider;
			if (forceUpdate) update();
		}
		
		public function update():void 
		{
			clear();
			buttons = new Vector.<Ibtn>;
			if (layoutProvider is IlistLayoutFactory) layout = (layoutProvider as IlistLayoutFactory).createLayout();
			else if (layoutProvider is Function) layout = layoutProvider();
			else layout = new SimpleListLayout();
			addElement(layout);
			
			var btn:Ibtn;
			for (var i:int = 0; i < btnNames.length; i++) 
			{
				btn = btnProvider.createButton(btnNames[i]);
						
				btn.setHandler(onBtnTap, btnNames[i]);
				buttons.push(btn);
				layout.addItem(btn);
			}
		}
		public function getBtn(name:String):Ibtn
		{
			for (var i:int = 0; i < btnNames.length; i++) 
			{
				if (name == btnNames[i])
				return buttons[i];
			}
			return null;
		}
		
		
		private function onBtnTap(name:String):void 
		{
			if (_handler is Function) _handler(name);
			dispatchEvent(new BtnMenuEvent(BtnMenuEvent.BTN_TAP, name));
		}
		private function clear():void
		{
			if (!layout) return;
			for (var i:int = buttons.length - 1; i >= 0; i--)
			{
				buttons[i].dispose();
			}
			buttons = null;
			
			layout.dispose();
			layout = null;
		}
		override public function dispose():void 
		{
			clear();
			super.dispose();
		}
		
		
	}

}