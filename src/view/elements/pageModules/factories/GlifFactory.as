package view.elements.pageModules.factories 
{
	import flash.text.TextFieldType;
	import flash.utils.Dictionary;
	import PS.model.interfaces.IviewElement;
	import PS.view.textView.SimpleText;
	import Swarrow.view.glifs.IglifFactory;
	/**
	 * ...
	 * @author pall
	 */
	public class GlifFactory implements IglifFactory
	{
		protected var requiredPrams:Array;
		protected var factoryProps:Object
		public function GlifFactory(params:Object=null) 
		{
			factoryProps = params;
		}
		private function extend(base:Object, newParams:Object):void
		{
			if (!base || !newParams) return;
			for (var prop:String in newParams)
			{
				try { base[prop] = newParams[prop] }
				catch (e:Error) { throw e;}
			}
			
		}
		protected function creator(params:Object):IviewElement
		{
			throw 'must be overrided';
			return null;
		}
		
		public final function createGlif(params:Object=null):IviewElement
		{
			var p:Dictionary = new Dictionary();
			extend(p, factoryProps);
			extend(p, params);
			if(requiredPrams)
			{
				var prop:String;
				for (var i:int = 0; i < requiredPrams.length; i++) 
				{
					prop = requiredPrams[i];
					if (p[prop] == null || p[prop] == undefined)
					throw new Error('missed requiered parameter: ' + prop);
				}
			}
			return creator(p);
		}
	}

}