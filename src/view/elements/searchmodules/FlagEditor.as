package view.elements.searchmodules 
{
	import PS.model.dataProcessing.assetManager.ColorAsset;
	import PS.model.PsImage;
	import PS.view.button.BtnGroup;
	import PS.view.button.ButtonPhaze;
	import PS.view.button.interfaces.Ibtn;
	import PS.view.button.PsButton;
	import PS.view.factories.defaults.DefaultButtonFactory;
	import PS.view.textView.SimpleText;
	import view.constants.Fonts;
	import view.elements.searchmodules.interfaces.IflagEditor;
	/**
	 * ...
	 * @author 
	 */
	public class FlagEditor extends EditorBase implements IflagEditor
	{
		private var _title:String;
		
		private var switcher:Ibtn;
		public function FlagEditor(w:int) 
		{
			super(w);
			switcher = createBtn();
			addItem(switcher, 'source');
		}
		
		/* INTERFACE view.elements.searchmodules.interfaces.IflagEditor */
		
		public function getValue():Boolean 
		{
			return switcher.phaze == ButtonPhaze.ACTIVE;
		}
		
		public function setValue(value:Boolean):void 
		{
			if (value)
			switcher.setPhaze(ButtonPhaze.ACTIVE);
			else 
			switcher.setPhaze(ButtonPhaze.DEFAULT);
		}
		
		/* INTERFACE view.elements.searchmodules.interfaces.IflagEditor */
		
		public function get isEmpty():Boolean 
		{
			return !getValue();
		}
		
		private function createBtn():Ibtn
		{
			var res:PsButton = new PsButton(BtnGroup.TOGLE_SWITCH);
			var tf:SimpleText = new SimpleText();
			tf.defaultTextFormat = Fonts.HINTS;
			tf.width = 24;
			tf.height = 20;
			tf.selectable = false;
			res.addViewElement(tf, 'tf');
			res.setViewHandler(ButtonPhaze.ACTIVE, function(elt:Object):void { elt.tf.text = '[X]' } );
			res.setViewHandler(ButtonPhaze.DEFAULT, function(elt:Object):void { elt.tf.text = '[_]' } );
			return res;
		}
		
	}

}