package Swarrow.view.glifs 
{
	import flash.display.DisplayObject;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import PS.model.BaseSprite;
	import PS.model.interfaces.IviewElement;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.factories.interfaces.IbuttonFactory;
	import PS.view.textView.SimpleText;
	import Swarrow.view.layouts.ColumnsLayout;
	import Swarrow.view.layouts.LayoutBase;
	import Swarrow.view.layouts.LineLayout;
	import Swarrow.view.layouts.ListLayout;
	import view.elements.pageModules.factories.GlifFactory;
	/**
	 * ...
	 * @author 
	 */
	public class TableMaker implements IglifFactory
	{
		public static const COLUMNS:String = 'taglayout';
		public static const LIST:String = 'listlayout';
		public static const STRING:String = 'stringlayout';
		//protected static const TEXT:String = 'text';
		//protected static const PHOTOS3:String = 'photos3';
		public static const GRAPHICS:String = 'graphics';
		public static const GLIF:String = 'glif';
		public static const BUTTON:String = 'btn';
		
		
		private var factories:Dictionary;
		protected var restrictedFactoryNames:Array;
		public function TableMaker() 
		{
			factories = new Dictionary();
			restrictedFactoryNames = [COLUMNS, LIST, STRING, GRAPHICS, GLIF, BUTTON];
		}
		public function addGlifFactory(factory:Object, name:String):void
		{
			if (restrictedFactoryNames.indexOf(name))
			throw new Error('restricted factory name: ' + name);
			if ((factories is IglifFactory) ||
			(factories is Function && (factory as Function).length==1) ||
			factory is IviewElement)
			{
				factories[name] = factories;
			}
			else throw new Error('invalid factory parameter: ' + factory);
		}
		public function removeGlifFactory(selector:Object):void
		{
			var i:int = 0;
			for(var name:String in factories)
			{
				if (selector is String && name == selector)
				{
					delete factories[name];
					return;
				}
				if (selector is Number && selector == i)
				{
					delete factories[name];
					return;
				}
				if (selector is IglifFactory && selector == factories[name])
				{
					delete factories[name];
					return;
				}
				i++;
			}
			
		}
		/* INTERFACE Swarrow.view.glifs.IglifFactory */
		
		public function createGlif(params:Object = null):IviewElement 
		{
			return render(params);
		}
		protected function render(data:Object):IviewElement
		{
			var res:IviewElement;
			var layout:LayoutBase;
			var list:Array;
			var item:Object;
			var ve:IviewElement;
			trace('RENDER: ' + data.type);
			switch(data.type)
			{
				case LIST:
					layout = new ListLayout();
					layout.autoUpdate = false;
					list = data.list;
					for each(item in list)
					{
						item.parent = data;
						ve = render(item);
						layout.addElement(ve);
						
					}
					layout.update();
					res = layout;
					break;
					
				case STRING:
					layout = new LineLayout();
					layout.autoUpdate = false;
					list = data.list;
					for each(item in list)
					{
						
						item.parent = data;
						ve = render(item);
						
						layout.addElement(ve);
					}
					
					layout.update();
					res = layout;
					break;
					
				case COLUMNS:;
					if(!(data.placeMethod is Array))
					throw new Error('place method param is missed');
					
					layout = new ColumnsLayout(data.placeMethod as Array);
					layout.autoUpdate = false
					list = data.list;
					for each(item in list)
					{
						item.parent = data;
						ve = render(item);
						layout.addElement(ve);
					}
					layout.update();
					res = layout;
					break;
				case GRAPHICS:
					res = createGraphics(data);
					break;
				case GLIF:
					var params:Object = data.params;
					switch(true)
					{
						case data.provider is IglifFactory:
							res = (data.provider as IglifFactory).createGlif(params);
							break;
						case data.provider is Function:
							res = data.provider(params);
							break;
						case data.provider is IviewElement:
							res = data.provider as IviewElement;
							break;
						default:
							throw new Error('invalid glif provider type: ' + data.provider);
							break;
					}
					
					break;
				case BUTTON:
					res = createBtn(data);
					break;
				default: 
					if (factories[data.type])
					{
						switch(true)
						{
							case data.provider is GlifFactory:
								res = (factories[data.type] as IglifFactory).createGlif(params);
								break;
							case data.provider is Function:
								res =factories[data.type](params);
								break;
							case data.provider is IviewElement:
								res = factories[data.type] as IviewElement;
								break;
							default:
								throw new Error('invalid custom factory type: ' + factories[data.type]);
								break;
						}
					}
					else
					{
						trace('ERROR --------------');
						for (var prop:String in data) trace('data.' + prop + ' = ' + data[prop]);
						throw new Error('invalid data type: ' + data.type);
					}
					break;
			}
			return res;
			
			
		}
		private function getInheritableProperty(name:String, obj:Object):Object
		{
			if (!obj) return null;
			if (obj[name]) return obj[name];
			else return getInheritableProperty(name, obj.parent);
		}
		//factories:
		protected function createGraphics(data:Object):IviewElement
		{
			if (data.content is IviewElement) return data.content as IviewElement
			var res:BaseSprite = new BaseSprite;
			if (data.content is DisplayObject) res.addChild(data.content as DisplayObject);
			if (data.content is String)
			{
				var tf:SimpleText = new SimpleText();
				if (data.font is TextFormat) tf.defaultTextFormat = data.font;
				if(data.rectangle)tf.width = data.rectangle.width;
				tf.autoSize = 'left';
				tf.multiline = false;
				tf.wordWrap = false;
				tf.text = String(data.content);
				res.addChild(tf);
			}
			return res;
		}
		protected function createBtn(data:Object):IviewElement
		{
			var btnName:String = '';
			var res:Ibtn;
			if (data.content is Ibtn) res = data.content as Ibtn;
			else
			{
				if (data.name) btnName = data.name;
				if (data.factory is IbuttonFactory) res = (data.factory as IbuttonFactory).createButton(btnName);
				else if (data.factory is Function) res = data.factory(btnName);
				else res = DefaultButtonFactory.createBtn(btnName);
			}
			if (data.handler is Function)
			{
				if (data.handlerParams) res.setHandler(data.handler as Function, data.handlerParams);
				else res.setHandler(data.handler as Function, data.handlerParams);
			}
			if (data.group) res.group = data.group;
			
			return res;
		}
	}

}