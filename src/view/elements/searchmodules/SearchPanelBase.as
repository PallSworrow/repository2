package view.elements.searchmodules {
	import adobe.utils.CustomActions;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import model.profiles.interfaces.IsearchRequest;
	import PS.model.BaseSprite;
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.dataProcessing.assetManager.Iasset;
	import PS.model.interfaces.IviewElement;
	import PS.model.PsImage;
	import PS.view.button.BtnGroup;
	import PS.view.button.ButtonPhaze;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.button.PsButton;
	import PS.view.clouds.CloudWindowLayers;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.layouts.implementations.listTyped.SimpleListLayout;
	import PS.view.layouts.interfaces.IlistLayout;
	import PS.view.layouts.LayoutEvent;
	import PS.view.scaleImage.scale3Image;
	import PS.view.scroller.interfaces.IlistScroller;
	import PS.view.scroller.ListScroller;
	import PS.view.textView.SimpleText;
	import view.constants.Fonts;
	import view.constants.ViewEvent;
	import view.elements.searchmodules.FlagEditor;
	import view.elements.searchmodules.interfaces.Ieditor;
	import view.elements.searchmodules.interfaces.IflagEditor;
	import view.elements.searchmodules.interfaces.IoptionEditor;
	import view.elements.searchmodules.interfaces.ItagEditor;
	import view.elements.searchmodules.interfaces.ItextEditor;
	import view.elements.searchmodules.OptionEditor;
	import view.elements.searchmodules.OptionStringEditor;
	import view.elements.searchmodules.TagsModule;
	import view.elements.searchmodules.TextInputModule;
	import view.factories.SimpleTextFactory;
	
	/**
	 * ...
	 * @author 
	 */
	public class SearchPanelBase extends BaseSprite 
	{
		protected static const TEXT:String = 'text';
		protected static const TAGS:String = 'tags';
		protected static const FLAG:String = 'flag';
		protected static const FLAG3:String = 'flag3';
		protected static const LIST:String = 'list';
		protected static const SELECTOR:String = 'selector';
		protected static const SELECTOR_STRING:String = 'selector2';
		/*
		private var _city:String;
		private var _style:Vector.<String> = new Vector.<String>;
		private var _needAudio:Boolean;
		private var _needVideo:Boolean;
		private var _localTours:Boolean;
		private var _worldTours:Boolean;
		private var _readyForLocalTours:Boolean;
		private var _readyForWorldTours:Boolean;
		private var _goals:Vector.<String> = new Vector.<String>;
		private var _skill:int;
		private var _isForFree:Boolean;
		private var _requireFullStyleMatch:Boolean = false;
		private var _requireFullGoalMatch:Boolean = false;
		*/
	
		private var layout:IlistLayout;
		private var searchBtn:Ibtn
		private var editors:Vector.<Ieditor>;
		private var folders:Vector.<IlistLayout>
		private var scroller:ListScroller;
		private var bg:PsImage;
		private static const asset:Iasset = new ColorAsset(100, 100, 0xf4f4f4);
		public function SearchPanelBase() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			bg = new PsImage(asset);
			
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			CloudWindowLayers.addLayer('ReqPanel', stage);
			editors = new Vector.<Ieditor>;
			scroller = new ListScroller(200, 500);
			//scroller.draggable = false;
			scroller.snapToPages = false;
			scroller.autoFreeSpace = false;
			//scroller.draggable = true;
			
			layout = createModuleList(init());
			(layout as EventDispatcher).addEventListener(LayoutEvent.UPDATE, onLayoutUpdate);
			//create
			//init
			//place&add
			addChild(bg);
			addElement(scroller);
			scroller.addItem(layout);
			function onLayoutUpdate(e:Event):void
			{
				scroller.update();
			}
		}
		override public function get width():Number 
		{
			return bg.width;
		}
		override public function get height():Number 
		{
			return bg.height;
		}
		
		override public function set height(value:Number):void 
		{
			//scroller.height = value;
			scroller.y = 10;
			scroller.height = value-20;
			bg.height = value
		}
		override public function set width(value:Number):void 
		{
			scroller.x = 5;
			scroller.width = value-10;
			bg.width = value;
		}
		private function editor_update(e:ViewEvent):void 
		{
			layout.update();
		}
		
		private function onSearchBtn():void 
		{
			dispatchEvent(new Event('SEARCH_BTN'));
		}
		protected function init():Array
		{
			return null;
		}
		public function getCurrentReq():String
		{
			var res:String = '{';
			var editor:Ieditor;
			var value:String;
			var prop:String;
			var props:Array=[];
			for (var i:int = 0; i < editors.length; i++) 
			{
				editor = editors[i];
				if (!editor) continue;
				prop = '"'+editor.propName+'"';
				if (editor is ItagEditor)
				{
					value = '[' + (editor as ItagEditor).getTagsG() + ']';
					props.push('"'+editor.propName+'G' + '": ' + value);
					
					value = '[' + (editor as ItagEditor).getTagsY() + ']';
					props.push('"'+editor.propName+'Y' + '": ' + value);
					
					value = '[' + (editor as ItagEditor).getTagsR() + ']';
					props.push('"'+editor.propName+'R' + '": ' + value);
				}
				else if (editor is ItextEditor)
				{
					value = '' + (editor as ItextEditor).getValue() + '';
					if(value && value != '')
					props.push(prop + ': "' + value+'"');
				}
				else if(editor is IflagEditor)
				{
					value = '' + String((editor as IflagEditor).getValue()) + '';
					if(value && value != '')
					props.push(prop + ': "' + value+'"');
				}
				else if (editor is IoptionEditor)
				{
					value = '' + String((editor as IoptionEditor).getValue()) + '';
					if(value && value != '')
					props.push(prop + ': "' + value+'"');
				}
				
				else throw new Error('unknown editor type: ' + editor);
				
					
				
			/*	else if (editor.isNecessery)
				{
					//TODO: incorrect request;
					return null;
				}*/
				
			}
			res += props.join(',');
			res += '}';
			return res;
		}
	
		override public function dispose():void 
		{
			layout.dispose();
			layout = null;
			super.dispose();
		}
		//init:
		/*
		protected function loadTemplate(req:IsearchRequest):void
		{
			
		}
		protected function getRequest():IsearchRequest
		{
			
		}*/
		//factories:
		protected function createModuleList(data:Array, owner:Ieditor = null ):IlistLayout
		{
			var res:SimpleListLayout;
			res = new SimpleListLayout();
			var editor:Ieditor;
			var group:IviewElement;
			var subEditors:IlistLayout;
			data = data.reverse();
			for each (var item:Object in data) 
			{
				switch(item.type)
				{
					case TAGS:
						editor = createTagBox(item.values);
						break;
					case TEXT:
						editor = createTextBox(item.valueOptions,item.values);
						break;
					case FLAG:
						editor = createFlagBox(item.defaultValue);
						break;
					case SELECTOR:
						editor = new OptionEditor(item.values,scroller.width-1);
						break;
					case SELECTOR_STRING:
						editor = new OptionStringEditor(item.values,scroller.width-1);
						break;
					case LIST:
						
						group = createModuleFolder(item.name, item.list);
						break;
				}
			
				if (editor) 
				{
					editor.addEventListener(ViewEvent.UPDATE, onElementUpdate);
					//trace(this, 'title: ' + item.title);
					editor.title = String(item.title);
					editor.propName = item.name;
					if (item.valueFilter is Function) editor.valueFilter = item.valueFilter;
					if (item.necessery) editor.isNecessery = true;
					
					res.addItemTo(editor,0);
					editors.push(editor);
					
					if (item.subEditors)
					{
						subEditors = createModuleList(item.subEditors);
						(subEditors as DisplayObject).addEventListener(LayoutEvent.UPDATE, onElementUpdate);
						editor.setUpdateHandler(onEditorUpdate, { owner:editor, subList:subEditors, container:res } );
					}
				}
				else if (group)
				{
					(group as DisplayObject).addEventListener(LayoutEvent.UPDATE, onElementUpdate);
					res.addItemTo(group,0);
				}
				
				editor = null;
				group = null;
				subEditors = null;
			}
			//folders.push(res);
			/*if (owner)
			{
				owner.addEventListener(ViewEvent.UPDATE, function(e:Event):void
				{
					if ((e.target as Ieditor).isEmpty) res.visible = false;
					else res.visible = true;
				});
			}*/
	
			return res;
			function onEditorUpdate(params:Object):void
			{
				var owner:Ieditor = params.owner;
				var sublist:IviewElement = params.subList;
				var container:IlistLayout = params.container;
				//trace(this ,owner, 'onEditorUpdate');
				//trace(this , 'is empty:',owner.isEmpty);
				
				var index:int = container.getIndexOf(owner);
				if (owner.isEmpty) sublist.remove();
				else 
				{
					container.addItemTo(sublist, index + 1);
					container.addItemTo(owner, index);
				}
				container.update();
			}
			
			function onElementUpdate(e:Event):void
			{
				//trace(e.target, 'onElementUpdate');
				res.update();
			}
		}
		protected function createTextBox(valueOptions:Vector.<String>, values:Array):ItextEditor
		{
			return new TextInputModule(values,scroller.width-1);
		}
		protected function createFlagBox(defaultValue:Boolean):IflagEditor
		{
			return new FlagEditor(scroller.width-1);
		}
		protected function createTagBox(values:Array):ItagEditor
		{
			return new TagsModule(values,scroller.width-1);
		}
		protected function createModuleFolder(name:String,sublist:Array):IviewElement
		{
			var res:BaseSprite = new BaseSprite();
			var btn:PsButton = new PsButton();
			var tf:SimpleText = SimpleTextFactory.inst.createText();
			tf.defaultTextFormat = Fonts.SMALL_TITLE;
			tf.width = scroller.width;
			tf.text = name+'\\/';
			//tf.addEventListener(MouseEvent.CLICK, onbtntap);
			btn.addViewElement(tf, 'tf');
			
			
			
			
		/*	res.graphics.beginFill(0x234545,0.5);
			res.graphics.drawRect(0, 0, tf.width, tf.height);
			res.graphics.endFill();*/
			res.addChild(btn);
			
			var mlist:IlistLayout = createModuleList(sublist);
			mlist.x = 0;
			mlist.y = res.height;
			btn.setHandler(onbtntap, { list:mlist, obj:res } );
			(mlist as DisplayObject).addEventListener(LayoutEvent.UPDATE, function(e:LayoutEvent):void 
			{
				res.dispatchEvent(e) 
			} );
			return res;
			
			function onbtntap(params:Object):void
			{
				if ((params.list as DisplayObject).parent) params.list.remove();
				else params.obj.addElement(params.list);
				params.obj.dispatchEvent(new LayoutEvent(LayoutEvent.UPDATE));
			}
			
		}
		
	}

}