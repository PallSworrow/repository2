package view.elements.pageModules.factories 
{
	import flash.text.TextFormat;
	import PS.model.interfaces.IviewElement;
	import Swarrow.tools.dataObservers.BooleanObserver;
	import Swarrow.tools.dataObservers.IntegerObserver;
	import view.constants.Fonts;
	import view.elements.pageModules.Flag2Module;
	import view.elements.pageModules.FlagModule;
	/**
	 * ...
	 * @author pall
	 */
	public class CheckBoxGlifFactory extends GlifFactory 
	{
		
		public function CheckBoxGlifFactory(params:Object=null) 
		{
			super(params);
			
		}
		override protected function creator(params:Object):IviewElement 
		{
			var data:Object = params;
			var res:FlagModule;
			var alt:Flag2Module;
			var format:TextFormat;
			if (data.font is TextFormat) format = data.font;
			else format = Fonts.SIMPLE;
			
			if (data.manager is IntegerObserver)
			{
				alt = new Flag2Module(data.manager as IntegerObserver, 
				String(data.name),
				data.factory, 
				data.options,
				format);
				alt.editable = Boolean(data.editable);
				return alt;
			}
			else if(data.manager is BooleanObserver)
			{
				res = new FlagModule(data.manager as BooleanObserver,
				data.factory,
				String(data.name),
				format);
				res.editable = Boolean(data.editable);
				return res;
			}
			
			throw new Error('invalid manager: ' + data.manager);
			return null;
		}
	}

}