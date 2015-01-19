package view.elements.pageModules.factories 
{
	import PS.model.interfaces.IviewElement;
	import PS.view.textView.SimpleText;
	import Swarrow.tools.dataObservers.IntegerObserver;
	import view.elements.pageModules.TextModule;
	/**
	 * ...
	 * @author pall
	 */
	public class TextModuleFactory extends GlifFactory 
	{
		
		public function TextModuleFactory(params:Object=null) 
		{
			super(params);
			requiredPrams = ['provider','manager'];
		}
		override protected function creator(params:Object):IviewElement 
		{
			/*
			provider - req
			manager - req
			font
			width
			maxChars
			editable
			
			*/
			var data:Object = params;
			var provider:Function = function():SimpleText
			{
				var tf:SimpleText = data.provider();
				tf.defaultTextFormat = data.font;
				if(data.width is Number)tf.width = data.width;
				if(data.width is IntegerObserver)tf.width = data.width.currentValue;
				if (data.maxChars) tf.maxChars = data.maxChars;
				tf.autoSize = 'left';
				return tf;
			}
			var res:TextModule = new TextModule(data.manager, provider, params.editable);
			return res;
		}
	}

}