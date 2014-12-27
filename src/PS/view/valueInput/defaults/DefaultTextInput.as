package PS.view.valueInput.defaults 
{
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import PS.view.textView.interfaces.ItextBox;
	import PS.view.textView.SimpleText;
	import PS.view.valueInput.textTyped.TextInput;
	
	/**
	 * ...
	 * @author 
	 */
	public class DefaultTextInput extends TextInput 
	{
		
		public function DefaultTextInput(rectangle:Rectangle) 
		{
			super(rectangle);
			var textField:SimpleText = new SimpleText();
			textField.width = rectangle.width;
			textField.height = rectangle.height;
			textField.type = TextFieldType.INPUT;
			addtextField(textField);
			
		}
		
	}

}