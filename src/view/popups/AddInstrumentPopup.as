package view.popups 
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import model.constants.InstrumentType;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.dataProcessing.assetManager.Iasset;
	import PS.model.popupSystem.Popup;
	import PS.model.PsImage;
	import PS.view.button.PsButton;
	import PS.view.scroller.interfaces.Ipage;
	import PS.view.scroller.ListScroller;
	import PS.view.scroller.pages.EmptyPage;
	import PS.view.textView.SimpleText;
	import Swarrow.models.Globals;
	import view.factories.InstrumentIconFactory;
	
	/**
	 * ...
	 * @author 
	 */
	public class AddInstrumentPopup extends Popup 
	{
		private var layout:ListScroller;
		private var bg:PsImage;
		private static const asset:Iasset = new ColorAsset(200, 400);
		private var handler:Function;
		public function AddInstrumentPopup() 
		{
			super();
			
		}
		override public function show(parameters:Object = null):void 
		{
			super.show(parameters);
			var currentList:Vector.<String> = parameters.list;
			layout = new ListScroller(200, 400);
			layout.itemProvider = itemProvider;
			bg = new PsImage(asset);
			handler = parameters.handler;
			bg.x = (Globals.width - bg.width) / 2;
			bg.y = (Globals.height - bg.height) / 2;
			layout.x = (Globals.width - layout.width) / 2;
			layout.y = (Globals.height - layout.height) / 2;
			
			addElement(layout);
			
			trace(this, 'current: ' + currentList);
			trace(this, 'total: ' + InstrumentType.list);
			for each(var type:String in InstrumentType.list) 
			{
					trace(this, 'show ' + type); 
				if (currentList.indexOf(type) == -1)
				{
					layout.addItem(type);
				}
				
			}
			function itemProvider(data:Object):Ipage
			{
				var res:EmptyPage = new EmptyPage();
				var btn:PsButton = new PsButton();
				var tf:SimpleText = new SimpleText();
				tf.text = String(data);
				var img:DisplayObject = InstrumentIconFactory.createIcon(String(data));
				tf.x = img.width;
				btn.addChild(img);
				btn.addChild(tf);
				//res.addEventListener(MouseEvent.CLICK, function():void { onItemClick(String(data)); } );
				res.addChild(btn);
				btn.setHandler(onItemClick, tf.text);
				res.graphics.beginFill(0xffffff);
				res.graphics.drawRect(0, 0, res.width, res.height);
				res.graphics.endFill();
				return res;
			}
		}
		private function onItemClick(type:String):void
		{
			handler(type);
			close();
		}
		override public function close(parameters:Object = null):void 
		{
			
			super.close(parameters);
		}
	}

}