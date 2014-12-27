package view.elements.searchmodules 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import PS.model.interfaces.IviewElement;
	import PS.view.clouds.CloudWindow;
	import PS.view.clouds.interfaces.IcloudWindow;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.layouts.implementations.listTyped.StringListLayout_light;
	import PS.view.layouts.interfaces.IlistLayout;
	import PS.view.textView.SimpleText;
	import view.constants.Fonts;
	import view.constants.ViewEvent;
	import view.elements.parts.HelpWindowElement;
	import view.elements.parts.TagView;
	import view.elements.searchmodules.interfaces.ItagEditor;
	import view.factories.InputTextFactory;
	
	/**
	 * ...
	 * @author 
	 */
	public class TagsModule extends EditorBase implements ItagEditor 
	{
		private var currentList:Vector.<String>;
		private var valuesList:Array;
		
		
		private var source:SimpleText;
		private var tagsOverview:IlistLayout;
		private var tagsOptions:IlistLayout;
		
		private var cloud:IcloudWindow;
		public function TagsModule(values:Array,w:int) 
		{
			super(w);
			valuesList = values;
			if (!valuesList) valuesList = [];
			currentList = new Vector.<String>;
			
			source = InputTextFactory.inst.createText();
			source.width = w;
			source.maxChars = 20;
			source.defaultTextFormat = Fonts.HINTS;
			source.addEventListener(Event.CHANGE, source_textInput);
			
			tagsOverview = new StringListLayout_light(new Rectangle(0, 0, 300, 100));
			tagsOptions = new SimpleListLayout();
			source.addEventListener(FocusEvent.FOCUS_OUT, source_focusOut);
			addItem(source, 'source');
			addItem(tagsOverview, 'overview');
			//addItem(tagsOptions, 'list');
			
			cloud = new CloudWindow(tagsOptions as DisplayObject);
			cloud.offsetY = source.height;
			cloud.init(source, 'ReqPanel',source);
			
		}
		
		private function source_focusOut(e:FocusEvent):void 
		{
			source.text = '';
		}
		
		private function createTag(value:String):IviewElement
		{
			var res:TagView = new TagView(value);
			res.addEventListener('TAP', tag_remove);
			return res;
		}
		
		private function tag_remove(e:Event):void 
		{
			for (var i:int = 0; i < tagsOverview.length; i++) 
			{
				if(tagsOverview.getItem(i) == e.target)
				{
					removeTag(i);
					return;
				}
			}
			
		}
		private function createValueElement(value:String):IviewElement
		{
			var res:HelpWindowElement = new HelpWindowElement(value,source.width);
			res.addEventListener('TAP', option_tap);
			return res;
		}
		
		private function option_tap(e:Event):void 
		{
			source.text = '';
			tagsOptions.clear();
			addTag((e.target as HelpWindowElement).getValue());
		}
		
		override protected function nativePlaceMethod(item:IviewElement, tag:String):void 
		{
			super.nativePlaceMethod(item, tag);
			if (tag == 'overview')
			{
				item.x = getItem('source').x;
				item.y = getItem('source').y+getItem('source').height;
			}
		}
		private function source_textInput(e:Event):void 
		{
			tagsOptions.clear();
			var curr:String = source.text.toLocaleLowerCase();
			var val:String;
			for (var i:int = 0; i < valuesList.length; i++) 
			{
				val = String(valuesList[i]).toLocaleLowerCase()
			//trace(this, 'help: ' + curr, val);
				if (curr != '' && val.search(curr) == 0 && currentList.indexOf(val) == -1)
				tagsOptions.addItem(createValueElement(valuesList[i]));
			}
		}
		
		/* INTERFACE view.elements.searchmodules.interfaces.ItagEditor */
		
		
		
		public function setValue(value:Vector.<String>):void 
		{
			currentList = value;
		}
		
		public function addTag(tag:String):void 
		{
			currentList.push('"'+tag+'"');
			tagsOverview.addItem(createTag(tag));
			updateSize();
		}
		
		public function removeTag(index:int):void 
		{
			currentList.splice(index, 1);
			tagsOverview.removeByIndex(index);
			updateSize();
		}
		
		public function loadTagList(list:Vector.<String>):void 
		{
			//tagsOptions = list;
		}
		
		/* INTERFACE view.elements.searchmodules.interfaces.ItagEditor */
		
		public function getTagsY():Vector.<String> 
		{
			return currentList;
		}
		
		public function getTagsR():Vector.<String> 
		{
			return new Vector.<String>
		}
		
		public function getTagsG():Vector.<String> 
		{
			
			return new Vector.<String>
		}
		
		/* INTERFACE view.elements.searchmodules.interfaces.ItagEditor */
		
		public function get isEmpty():Boolean 
		{
			return false;
		}
		
		
		private function updateSize():void
		{
			borderHeight = source.y + source.height + tagsOverview.height;
			super.update();
			dispatchEvent(new ViewEvent(ViewEvent.UPDATE));
		}
		
	
		
	}

}