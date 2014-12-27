package view.factories 
{
	import flash.text.TextFieldType;
	import PS.view.factories.interfaces.ItextFactory;
	import PS.view.textView.SimpleText;
	
	/**
	 * ...
	 * @author 
	 */
	public class InputTextFactory implements ItextFactory 
	{
		public static const inst:ItextFactory = new InputTextFactory();
		
		public function InputTextFactory() 
		{
			
		}
		
		/* INTERFACE PS.view.factories.interfaces.ItextFactory */
		
		public function createText():SimpleText 
		{
			var res:SimpleText = new SimpleText();
			res.wordWrap = true;
			res.border = true;
			res.autoSize = 'center';
			res.type = TextFieldType.INPUT;
			return res;
		}
		
	}

}