package view.factories 
{
	import flash.text.TextFieldType;
	import PS.view.factories.interfaces.ItextFactory;
	import PS.view.textView.SimpleText;
	
	/**
	 * ...
	 * @author 
	 */
	public class SimpleTextFactory implements ItextFactory 
	{
		public static const inst:ItextFactory = new SimpleTextFactory();
		
		public function SimpleTextFactory() 
		{
			
		}
		
		/* INTERFACE PS.view.factories.interfaces.ItextFactory */
		
		public function createText():SimpleText 
		{
			var res:SimpleText = new SimpleText();
			res.wordWrap = true;
			res.height = 25;
			//res.border = true;
			res.autoSize = 'none';
			//res.type = TextFieldType.INPUT;
			return res;
		}
		
	}

}