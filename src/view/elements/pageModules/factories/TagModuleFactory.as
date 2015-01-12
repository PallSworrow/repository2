package view.elements.pageModules.factories 
{
	import PS.model.interfaces.IviewElement;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import Swarrow.tools.dataObservers.IntegerObserver;
	import view.constants.Fonts;
	import view.elements.TagsModule;
	import view.factories.btns.TagFactory;
	/**
	 * ...
	 * @author pall
	 */
	public class TagModuleFactory extends GlifFactory 
	{
		/*
		color
		title
		manager
		editable
		*/
		public function TagModuleFactory(params:Object=null) 
		{
			super(params);
			
		}
		override protected function creator(params:Object):IviewElement 
		{
			var res:TagsModule = new TagsModule(params.title,params.manager, new TagFactory(params.color), DefaultButtonFactory.inst, params.editable);
			if(params.width is Number)
			res.width = params.width;
			else if (params.width is IntegerObserver)
			res.width = params.width.currentValue;
			
			return res;
		}
	}

}